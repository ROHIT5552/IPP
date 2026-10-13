import { BadRequestException, Injectable, NotFoundException } from "@nestjs/common";
import { PrismaService } from "../prisma/prisma.service";
import { FACTOR_SECTIONS, QUESTION_INDEX, QUESTION_SECTION, QUESTIONNAIRE, suggestedRating } from "./questionnaire.catalog";

@Injectable()
export class QuestionnaireService {
  constructor(private readonly prisma: PrismaService) {}

  async get(gesId: string, ippId: string) {
    const [ges, ipp] = await Promise.all([
      this.prisma.gES.findUnique({ where: { id: gesId }, select: { id: true, name: true } }),
      this.prisma.iPP.findUnique({ where: { id: ippId }, select: { id: true, name: true } }),
    ]);
    if (!ges) throw new NotFoundException("GES account was not found");
    if (!ipp) throw new NotFoundException("IPP was not found");
    const saved = await this.prisma.questionnaireAnswer.findMany({ where: { gesId, ippId } });
    const values = new Map(saved.map((row) => [row.questionKey, row]));
    const sections = QUESTIONNAIRE.map((section) => {
      const questions = section.questions.map((question) => ({
        ...question,
        value: values.get(question.key)?.value ?? "",
      }));
      const savedRating = values.get(sectionKey(section.id))?.rating ?? null;
      return { ...section, questions, rating: savedRating, suggested: sectionSuggestion(questions) };
    });
    const total = sections.reduce((count, section) => count + section.questions.length, 0);
    const answered = sections.reduce(
      (count, section) => count + section.questions.filter((question) => question.value.trim()).length,
      0,
    );
    return { gesId: ges.id, gesName: ges.name, ippId: ipp.id, ippName: ipp.name, answered, total, sections };
  }

  async save(gesId: string, ippId: string, answers: Record<string, unknown>, sectionRatings: Record<string, unknown>, userId: string) {
    const [ges, ipp] = await Promise.all([
      this.prisma.gES.findUnique({ where: { id: gesId }, select: { id: true } }),
      this.prisma.iPP.findUnique({ where: { id: ippId }, select: { id: true } }),
    ]);
    if (!ges) throw new NotFoundException("GES account was not found");
    if (!ipp) throw new NotFoundException("IPP was not found");
    const rows = Object.entries(answers ?? {});
    const ratingRows = Object.entries(sectionRatings ?? {});
    if (!rows.length && !ratingRows.length) throw new BadRequestException("Nothing to save");
    const prepared = rows.map(([key, raw]) => {
      const question = QUESTION_INDEX.get(key);
      if (!question) throw new BadRequestException("One of the answers is not part of this questionnaire");
      const record = raw && typeof raw === "object" ? (raw as { value?: unknown }) : { value: raw };
      const value = String(record.value ?? raw ?? "").trim();
      if (value.length > 4000) throw new BadRequestException(`${question.prompt} is too long`);
      if (question.kind === "numeric" && value !== "" && !Number.isFinite(Number(value))) {
        throw new BadRequestException(`${question.prompt} needs a number`);
      }
      return { questionKey: key, value, rating: null as number | null };
    });
    const knownSections = new Set(QUESTIONNAIRE.map((section) => section.id));
    for (const [sectionId, raw] of ratingRows) {
      if (!knownSections.has(sectionId)) throw new BadRequestException("One of the section ratings is not part of this questionnaire");
      const section = QUESTIONNAIRE.find((item) => item.id === sectionId);
      prepared.push({
        questionKey: sectionKey(sectionId),
        value: "",
        rating: cleanRating(raw, section?.title ?? "Section"),
      });
    }
    await this.prisma.$transaction(
      prepared.map((row) =>
        this.prisma.questionnaireAnswer.upsert({
          where: { gesId_ippId_questionKey: { gesId, ippId, questionKey: row.questionKey } },
          create: { gesId, ippId, questionKey: row.questionKey, value: row.value, rating: row.rating, updatedById: userId },
          update: { value: row.value, rating: row.rating, updatedById: userId },
        }),
      ),
    );
    return this.get(gesId, ippId);
  }

  async factorScores(gesId: string, ippIds: string[]) {
    if (!ippIds.length) return new Map<string, { key: string; average: number; count: number }[]>();
    const saved = await this.prisma.questionnaireAnswer.findMany({
      where: { gesId, ippId: { in: ippIds } },
      select: { ippId: true, questionKey: true, value: true, rating: true },
    });
    const explicit = new Map<string, Map<string, number>>();
    const fallback = new Map<string, Map<string, number[]>>();
    for (const row of saved) {
      if (!row.ippId) continue;
      if (row.questionKey.startsWith("section:")) {
        if (row.rating == null) continue;
        const sectionId = row.questionKey.slice("section:".length);
        const bucket = explicit.get(row.ippId) ?? new Map<string, number>();
        bucket.set(sectionId, row.rating);
        explicit.set(row.ippId, bucket);
        continue;
      }
      const question = QUESTION_INDEX.get(row.questionKey);
      const section = QUESTION_SECTION.get(row.questionKey);
      if (!question || !section) continue;
      const rating = row.rating ?? suggestedRating(question.kind, row.value);
      if (rating == null) continue;
      const bucket = fallback.get(row.ippId) ?? new Map<string, number[]>();
      const list = bucket.get(section) ?? [];
      list.push(rating);
      bucket.set(section, list);
      fallback.set(row.ippId, bucket);
    }
    const result = new Map<string, { key: string; average: number; count: number }[]>();
    for (const ippId of ippIds) {
      const chosen = explicit.get(ippId) ?? new Map<string, number>();
      const suggested = fallback.get(ippId) ?? new Map<string, number[]>();
      result.set(
        ippId,
        Object.entries(FACTOR_SECTIONS).map(([key, sectionIds]) => {
          const ratings = sectionIds.flatMap((sectionId) => {
            const savedRating = chosen.get(sectionId);
            if (savedRating != null) return [savedRating];
            return suggested.get(sectionId) ?? [];
          });
          const average = ratings.length ? ratings.reduce((total, value) => total + value, 0) / ratings.length : 0;
          return { key, average, count: ratings.length };
        }),
      );
    }
    return result;
  }

  async latestIppTariffs(gesId: string, ippIds: string[]) {
    const result = new Map<string, number>();
    if (!ippIds.length) return result;
    const rows = await this.prisma.tariffNegotiation.findMany({
      where: { gesId, ippId: { in: ippIds } },
      select: { ippId: true, rounds: true },
    });
    for (const row of rows) {
      const rounds = Array.isArray(row.rounds) ? row.rounds : [];
      for (let index = rounds.length - 1; index >= 0; index -= 1) {
        const rate = (rounds[index] as { ippTariff?: unknown } | null)?.ippTariff;
        const text = String(rate ?? "").trim();
        const number = Number(text);
        if (!text || !Number.isFinite(number)) continue;
        result.set(row.ippId, number);
        break;
      }
    }
    return result;
  }

  async tariffBoard(gesId: string) {
    const ges = await this.prisma.gES.findUnique({ where: { id: gesId }, select: { id: true, name: true } });
    if (!ges) throw new NotFoundException("GES account was not found");
    const [ipps, saved] = await Promise.all([
      this.prisma.iPP.findMany({
        select: { id: true, name: true, referenceNo: true, portfolioCapacity: true, headquarters: true, loiScope: true },
      }),
      this.prisma.tariffNegotiation.findMany({ where: { gesId } }),
    ]);
    const byIpp = new Map(saved.map((row) => [row.ippId, row]));
    const ordered = [...ipps].sort((left, right) => {
      const a = Number(left.referenceNo);
      const b = Number(right.referenceNo);
      const aRank = Number.isFinite(a) && left.referenceNo.trim() ? a : 10000;
      const bRank = Number.isFinite(b) && right.referenceNo.trim() ? b : 10000;
      if (aRank !== bRank) return aRank - bRank;
      return left.name.localeCompare(right.name);
    });
    return {
      gesId: ges.id,
      gesName: ges.name,
      rounds: TARIFF_ROUNDS,
      ipps: ordered.map((ipp) => {
        const row = byIpp.get(ipp.id);
        return {
          id: ipp.id,
          name: ipp.name,
          referenceNo: ipp.referenceNo,
          portfolioCapacity: ipp.portfolioCapacity,
          headquarters: ipp.headquarters,
          loiScope: ipp.loiScope,
          rounds: mergeRounds(row?.rounds),
          updatedAt: row?.updatedAt.toISOString() ?? null,
        };
      }),
    };
  }

  async saveTariffBoard(gesId: string, entries: unknown, userId: string) {
    const ges = await this.prisma.gES.findUnique({ where: { id: gesId }, select: { id: true } });
    if (!ges) throw new NotFoundException("GES account was not found");
    if (!Array.isArray(entries)) throw new BadRequestException("Negotiation rows are required");
    const ippIds = [...new Set(entries.map((entry) => String((entry as { ippId?: unknown })?.ippId ?? "")))].filter(Boolean);
    const known = await this.prisma.iPP.findMany({ where: { id: { in: ippIds } }, select: { id: true } });
    const knownIds = new Set(known.map((ipp) => ipp.id));
    const prepared = entries.map((entry) => {
      const row = entry as { ippId?: unknown; rounds?: unknown };
      const ippId = String(row.ippId ?? "");
      if (!knownIds.has(ippId)) throw new BadRequestException("One of the IPPs is not on the register");
      return { ippId, rounds: normalizeRounds(row.rounds) };
    });
    await this.prisma.$transaction(
      prepared.map((row) =>
        this.prisma.tariffNegotiation.upsert({
          where: { gesId_ippId: { gesId, ippId: row.ippId } },
          create: { gesId, ippId: row.ippId, rounds: row.rounds, updatedById: userId },
          update: { rounds: row.rounds, updatedById: userId },
        }),
      ),
    );
    return this.tariffBoard(gesId);
  }
}

const TARIFF_ROUNDS = 4;

function blankRound() {
  return { ippTariff: "", gesOffer: "", finalisedRate: "" };
}

function mergeRounds(value: unknown) {
  const source = Array.isArray(value) ? value : [];
  return Array.from({ length: TARIFF_ROUNDS }, (_, index) => normalizeRound(source[index], false));
}

function normalizeRounds(value: unknown) {
  const source = Array.isArray(value) ? value : [];
  return Array.from({ length: TARIFF_ROUNDS }, (_, index) => normalizeRound(source[index], true));
}

function normalizeRound(value: unknown, strict: boolean) {
  const row = value && typeof value === "object" ? (value as Record<string, unknown>) : {};
  return {
    ippTariff: cleanRate(row.ippTariff, strict),
    gesOffer: cleanRate(row.gesOffer, strict),
    finalisedRate: cleanRate(row.finalisedRate, strict),
  };
}

function cleanRate(value: unknown, strict: boolean) {
  const text = String(value ?? "").trim();
  if (!text) return "";
  const number = Number(text);
  if (!Number.isFinite(number) || number < 0) {
    if (!strict) return "";
    throw new BadRequestException("Tariff rates must be numbers in ₹/kWh");
  }
  return text;
}

function sectionKey(sectionId: string) {
  return `section:${sectionId}`;
}

function sectionSuggestion(questions: { kind: "numeric" | "text" | "long"; value: string }[]) {
  const scores = questions
    .map((question) => suggestedRating(question.kind, question.value))
    .filter((score): score is number => score != null);
  if (!scores.length) return null;
  return Math.round((scores.reduce((total, score) => total + score, 0) / scores.length) * 10) / 10;
}

function cleanRating(value: unknown, prompt: string) {
  if (value == null || value === "") return null;
  const number = Number(value);
  if (!Number.isFinite(number) || number < 0 || number > 10) {
    throw new BadRequestException(`${prompt} rating must be from 0 to 10`);
  }
  return Math.round(number * 10) / 10;
}
