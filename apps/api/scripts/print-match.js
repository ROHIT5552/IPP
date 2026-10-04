const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

async function main() {
  const rows = await prisma.loadMatchResult.findMany({ include: { ipp: true, ges: true } });
  for (const row of rows.filter((item) => ["ipp_sungrid", "ipp_novarenewable", "ipp_terragrid", "ipp_greenvolt"].includes(item.ippId))) {
    console.log(
      `${row.ges.name.slice(0, 16).padEnd(16)} ${row.ipp.name.slice(0, 22).padEnd(22)} match ${row.loadMatchPct.toFixed(1).padStart(6)} cover ${row.coveragePct.toFixed(1).padStart(6)} avail ${row.availableGwh.toFixed(0)} matched ${row.matchedGwh.toFixed(0)}`,
    );
  }
}

main().finally(() => prisma.$disconnect());
