import { Body, Controller, Delete, Get, Param, Patch, Post, Query, Req, Res, StreamableFile } from "@nestjs/common";
import { Request, Response } from "express";
import { Public, RequirePermissions } from "../common/http";
import { EnergyService } from "./energy.service";
import { ProcurementService } from "./procurement.service";

type RequestUser = Request & { user: { id: string; name?: string; permissions: string[]; roles?: string[]; gesId?: string | null } };

function accountGes(request: RequestUser, requested?: string) {
  return request.user.gesId || requested || "ges_aster";
}

@Controller()
export class PlatformController {
  constructor(
    private readonly energy: EnergyService,
    private readonly procurement: ProcurementService,
  ) {}

  @Public()
  @Get("health")
  health() {
    return { status: "ok", service: "newra-ges-ipp-comparator" };
  }

  @RequirePermissions("GES_VIEW")
  @Get("dashboard")
  dashboard(@Query("gesId") gesId: string | undefined, @Req() request: RequestUser) {
    return this.energy.dashboard(request.user.gesId || gesId, Boolean(request.user.gesId));
  }

  @RequirePermissions("GES_VIEW")
  @Get("ges")
  ges(@Req() request: RequestUser) {
    return this.energy.listGes(request.user.gesId);
  }

  @RequirePermissions("GES_CREATE")
  @Post("ges")
  createGes(@Body() body: Record<string, unknown>, @Req() request: RequestUser) {
    return this.energy.createGes(body, request.user);
  }

  @RequirePermissions("GES_VIEW")
  @Get("ges/:id")
  gesDetail(@Param("id") id: string) {
    return this.energy.getGes(id);
  }

  @RequirePermissions("REQUIREMENT_VIEW")
  @Get("ges/:id/requirements")
  requirement(@Param("id") id: string) {
    return this.procurement.requirement(id);
  }

  @RequirePermissions("REQUIREMENT_EDIT")
  @Patch(["ges/:id/requirement", "ges/:id/requirements"])
  updateRequirement(@Param("id") id: string, @Body() body: Record<string, unknown>, @Req() request: RequestUser) {
    return this.energy.updateRequirement(id, body, request.user).then(() => this.procurement.requirement(id));
  }

  @RequirePermissions("GES_VIEW")
  @Get("ges/:gesId/profile")
  profile(@Param("gesId") gesId: string) {
    return this.procurement.profile(gesId);
  }

  @RequirePermissions("GES_PROFILE_EDIT")
  @Patch("ges/:gesId/profile")
  patchProfile(@Param("gesId") gesId: string, @Body() body: Record<string, unknown>, @Req() request: RequestUser) {
    return this.procurement.patchProfile(gesId, body, request.user);
  }

  @RequirePermissions("SELECTION_VIEW")
  @Get("ges/:gesId/selections")
  selections(@Param("gesId") gesId: string) {
    return this.procurement.selections(gesId);
  }

  @RequirePermissions("SELECTION_CREATE")
  @Post("ges/:gesId/ipps/:ippId/consider")
  consider(@Param("gesId") gesId: string, @Param("ippId") ippId: string, @Req() request: RequestUser) {
    return this.procurement.consider(gesId, ippId, request.user);
  }

  @RequirePermissions("COMMERCIAL_REQUIREMENT_CREATE")
  @Post("ges/:gesId/selections/:selectionId/commercial-requirements")
  addCommercial(@Param("gesId") gesId: string, @Param("selectionId") selectionId: string, @Body() body: Record<string, unknown>, @Req() request: RequestUser) {
    return this.procurement.addCommercial(gesId, selectionId, body, request.user);
  }

  @RequirePermissions("IPP_VIEW")
  @Get("ges/:gesId/catalogue/:ippId")
  clientIpp(@Param("gesId") gesId: string, @Param("ippId") ippId: string) {
    return this.procurement.clientIpp(gesId, ippId);
  }

  @RequirePermissions("GES_EDIT")
  @Patch("ges/:id")
  updateGes(@Param("id") id: string, @Body() body: Record<string, unknown>, @Req() request: RequestUser) {
    return this.energy.updateGes(id, body, request.user);
  }

  @RequirePermissions("GES_EDIT")
  @Delete("ges/:id")
  removeGes(@Param("id") id: string, @Req() request: RequestUser) {
    return this.energy.deleteGes(id, request.user);
  }

  @RequirePermissions("GES_EDIT")
  @Post("ges/:gesId/ipps/:ippId/link")
  linkIpp(@Param("gesId") gesId: string, @Param("ippId") ippId: string, @Req() request: RequestUser) {
    return this.energy.linkIpp(gesId, ippId, request.user);
  }

  @RequirePermissions("IPP_VIEW")
  @Get("ges/:gesId/ipps")
  ipps(@Param("gesId") gesId: string) {
    return this.energy.providerOptions(gesId);
  }

  @RequirePermissions("IPP_VIEW")
  @Get("ipps")
  allIpps(@Query("gesId") gesId: string | undefined, @Req() request: RequestUser) {
    return this.energy.ippBoard(accountGes(request, gesId));
  }

  @RequirePermissions("IPP_VIEW")
  @Get("ipp-catalog")
  ippCatalog(@Req() request: RequestUser) {
    return this.energy.ippCatalog(request.user.gesId, { clientSafe: Boolean(request.user.gesId) });
  }

  @RequirePermissions("IPP_CREATE")
  @Post("ipps")
  createIpp(@Body() body: Record<string, unknown>, @Req() request: RequestUser) {
    return this.energy.createIpp(body, request.user);
  }

  @RequirePermissions("IPP_EDIT")
  @Patch("ipps/:id")
  updateIpp(@Param("id") id: string, @Body() body: Record<string, unknown>, @Req() request: RequestUser) {
    return this.energy.updateIpp(id, body, request.user);
  }

  @RequirePermissions("IPP_EDIT")
  @Delete("ipps/:id")
  removeIpp(@Param("id") id: string, @Req() request: RequestUser) {
    return this.energy.deleteIpp(id, request.user);
  }

  @RequirePermissions("IPP_VIEW")
  @Get("ges/:gesId/ipps/:ippId")
  ipp(@Param("gesId") gesId: string, @Param("ippId") ippId: string, @Req() request: RequestUser) {
    return this.energy.getIpp(gesId, ippId, request.user);
  }

  @RequirePermissions("IPP_VIEW")
  @Get("ipps/:id")
  ippById(@Param("id") id: string, @Req() request: RequestUser) {
    return this.energy.getIpp(accountGes(request), id, request.user);
  }

  @RequirePermissions("IPP_EDIT")
  @Patch(["ipps/:id/assumptions", "ipps/:id/input"])
  assumptions(@Param("id") id: string, @Body() body: Record<string, unknown>, @Req() request: RequestUser) {
    return this.energy.patchAssumptions(id, body, request.user);
  }

  @RequirePermissions("IPP_EDIT")
  @Post("ipps/:id/reset")
  reset(@Param("id") id: string, @Req() request: RequestUser) {
    return this.energy.resetIpp(id, request.user);
  }

  @RequirePermissions("EVALUATION_VIEW")
  @Get("ipps/:id/evaluation")
  evaluation(@Param("id") id: string, @Req() request: RequestUser) {
    return this.energy.getIpp(accountGes(request), id, request.user).then((ipp) => ipp.evaluation);
  }

  @RequirePermissions("EVALUATION_EDIT")
  @Post("ipps/:id/evaluation")
  recalculateIpp(@Param("id") id: string, @Req() request: RequestUser) {
    return this.energy.patchAssumptions(id, {}, request.user);
  }

  @RequirePermissions("EVALUATION_VIEW")
  @Get("ges/:gesId/ipps/:ippId/suitability")
  suitability(@Param("gesId") gesId: string, @Param("ippId") ippId: string, @Req() request: RequestUser) {
    return this.energy.getIpp(gesId, ippId, request.user).then((ipp) => ({ suitability: ipp.link, radar: ipp.radar }));
  }

  @RequirePermissions("EVALUATION_EDIT")
  @Post("ges/:gesId/ipps/:ippId/recalculate")
  recalculatePair(@Param("gesId") gesId: string, @Param("ippId") ippId: string, @Req() request: RequestUser) {
    return this.energy.patchAssumptions(ippId, {}, request.user).then(() => this.energy.getIpp(gesId, ippId, request.user));
  }

  @RequirePermissions("EVALUATION_VIEW")
  @Get("ges/:gesId/ipps/:ippId/load-match")
  loadMatch(@Param("gesId") gesId: string, @Param("ippId") ippId: string, @Req() request: RequestUser) {
    return this.energy.getIpp(gesId, ippId, request.user).then((ipp) => ipp.loadMatch);
  }

  @RequirePermissions("EVALUATION_EDIT")
  @Post("ges/:gesId/ipps/:ippId/load-match/calculate")
  calculateLoad(@Param("gesId") gesId: string, @Param("ippId") ippId: string, @Req() request: RequestUser) {
    return this.energy.patchAssumptions(ippId, {}, request.user).then(() => this.energy.getIpp(gesId, ippId, request.user).then((ipp) => ipp.loadMatch));
  }

  @RequirePermissions("TARIFF_REVIEW")
  @Get("ipps/:id/tariff")
  tariff(@Param("id") id: string, @Req() request: RequestUser) {
    return this.energy.getIpp(accountGes(request), id, request.user).then((ipp) => ipp.tariff);
  }

  @RequirePermissions("TARIFF_REVIEW")
  @Post("ipps/:id/tariff/scenario")
  scenario(@Param("id") id: string, @Body() body: Record<string, unknown>, @Req() request: RequestUser) {
    return this.energy.tariffScenario(id, body, request.user);
  }

  @RequirePermissions("EVALUATION_VIEW")
  @Get("ipps/:id/gates")
  gates(@Param("id") id: string, @Query("gesId") gesId = "ges_aster", @Req() request: RequestUser) {
    return this.energy.getIpp(accountGes(request, gesId), id, request.user).then((ipp) => ipp.gates);
  }

  @RequirePermissions("EVALUATION_VIEW")
  @Get("ipps/:id/red-flags")
  flags(@Param("id") id: string, @Query("gesId") gesId = "ges_aster", @Req() request: RequestUser) {
    return this.energy.getIpp(accountGes(request, gesId), id, request.user).then((ipp) => ipp.redFlags);
  }

  @RequirePermissions("EVALUATION_VIEW")
  @Post("comparisons")
  createComparison(@Body() body: { gesId: string; ippIds: string[] }, @Req() request: RequestUser) {
    return this.energy.comparison(body.gesId, body.ippIds ?? [], request.user);
  }

  @RequirePermissions("EVALUATION_VIEW")
  @Get("ges/:gesId/comparison")
  comparison(@Param("gesId") gesId: string, @Query("ippIds") ippIds = "", @Req() request: RequestUser) {
    return this.energy.presentComparison(gesId, ippIds.split(",").filter(Boolean), request.user);
  }

  @RequirePermissions("EVALUATION_EDIT")
  @Post("comparisons/:gesId/recalculate")
  recalculateComparison(@Param("gesId") gesId: string, @Body() body: { ippIds?: string[] }, @Req() request: RequestUser) {
    return this.energy.recalculate(gesId, body.ippIds).then(() => this.energy.comparison(gesId, body.ippIds ?? [], request.user));
  }

  @RequirePermissions("EVALUATION_VIEW")
  @Get("ges/:gesId/comparison/export.xlsx")
  async excel(@Param("gesId") gesId: string, @Query("ippIds") ippIds = "", @Req() request: RequestUser, @Res({ passthrough: true }) response: Response) {
    const payload = await this.energy.comparison(gesId, ippIds.split(",").filter(Boolean), request.user);
    response.setHeader("Content-Disposition", "attachment; filename=newra-comparison.xlsx");
    return new StreamableFile(await this.energy.comparisonWorkbook(payload));
  }

  @RequirePermissions("EVALUATION_VIEW")
  @Get("ges/:gesId/comparison/export.pdf")
  async pdf(@Param("gesId") gesId: string, @Query("ippIds") ippIds = "", @Req() request: RequestUser, @Res({ passthrough: true }) response: Response) {
    const payload = await this.energy.comparison(gesId, ippIds.split(",").filter(Boolean), request.user);
    response.setHeader("Content-Type", "application/pdf");
    response.setHeader("Content-Disposition", "attachment; filename=newra-comparison.pdf");
    return new StreamableFile(await this.energy.comparisonPdf(payload));
  }

  @RequirePermissions("COMMERCIAL_REVIEW")
  @Post("ges/:gesId/ipps/:ippId/shortlist")
  shortlist(@Param("gesId") gesId: string, @Param("ippId") ippId: string, @Body() body: { shortlisted?: boolean }, @Req() request: RequestUser) {
    return this.energy.setShortlist(gesId, ippId, body.shortlisted !== false, request.user);
  }

  @RequirePermissions("EVALUATION_VIEW")
  @Get("ges/:gesId/negotiations")
  negotiations(@Param("gesId") gesId: string) {
    return this.energy.flatOffers(gesId);
  }

  @RequirePermissions("NEGOTIATION_CREATE")
  @Post("ges/:gesId/negotiations/offers")
  addGesOffer(@Param("gesId") gesId: string, @Body() body: Record<string, unknown>, @Req() request: RequestUser) {
    return this.energy.addOffer(gesId, body, request.user);
  }

  @RequirePermissions("NEGOTIATION_CREATE")
  @Post("ges/:gesId/negotiations")
  openNegotiation(@Param("gesId") gesId: string, @Body() body: Record<string, unknown>, @Req() request: RequestUser) {
    return this.energy.addOffer(gesId, body, request.user);
  }

  @RequirePermissions("NEGOTIATION_CREATE")
  @Post("negotiations/:id/offers")
  addOffer(@Param("id") id: string, @Body() body: Record<string, unknown>, @Req() request: RequestUser) {
    return this.energy.addOfferToNegotiation(id, body, request.user);
  }

  @RequirePermissions("PSOA_VIEW")
  @Get("ges/:gesId/psoa")
  psoa(@Param("gesId") gesId: string, @Query("ippId") ippId?: string) {
    return this.energy.psoaRecords(gesId, ippId);
  }

  @RequirePermissions("PSOA_CREATE")
  @Patch("ges/:gesId/psoa/:ippId")
  patchPsoa(@Param("gesId") gesId: string, @Param("ippId") ippId: string, @Body() body: { item?: string; status?: string }, @Req() request: RequestUser) {
    return this.energy.updatePsoaItem(gesId, ippId, body, request.user);
  }

  @RequirePermissions("PSOA_CREATE")
  @Post("ges/:gesId/psoa")
  savePsoa(@Param("gesId") gesId: string, @Body() body: Record<string, unknown>, @Req() request: RequestUser) {
    return this.energy.savePsoa(gesId, body, request.user);
  }

  @RequirePermissions("DEALBOOK_VIEW")
  @Get("ges/:gesId/dealbook")
  dealbook(@Param("gesId") gesId: string, @Query("ippId") ippId = "", @Req() request: RequestUser) {
    if (ippId) return this.energy.dealbook(gesId, ippId, request.user);
    return this.energy.dealbooks(gesId, request.user);
  }

  @RequirePermissions("DOCUMENT_VIEW")
  @Get("ges/:gesId/documents")
  gesDocuments(@Param("gesId") gesId: string) {
    return this.energy.documentRows(gesId);
  }

  @RequirePermissions("DOCUMENT_UPLOAD")
  @Patch("documents/:id")
  updateDocument(@Param("id") id: string, @Body() body: { status?: string }, @Req() request: RequestUser) {
    return this.energy.updateDocument(id, body.status ?? "UNDER_REVIEW", request.user);
  }

  @RequirePermissions("DEALBOOK_VIEW")
  @Get("ges/:gesId/dealbook/export.pdf")
  async dealPdf(@Param("gesId") gesId: string, @Query("ippId") ippId = "", @Req() request: RequestUser, @Res({ passthrough: true }) response: Response) {
    const book = await this.energy.dealbook(gesId, ippId, request.user);
    response.setHeader("Content-Type", "application/pdf");
    response.setHeader("Content-Disposition", "attachment; filename=newra-dealbook.pdf");
    return new StreamableFile(await this.energy.comparisonPdf(book.comparison));
  }

  @RequirePermissions("DOCUMENT_VIEW")
  @Get("documents")
  documents(@Query("gesId") gesId: string | undefined, @Query("ippId") ippId: string | undefined, @Req() request: RequestUser) {
    return this.energy.documents(request.user.gesId || gesId, ippId);
  }

  @RequirePermissions("EVALUATION_VIEW")
  @Get("tasks")
  tasks(@Query("gesId") gesId: string | undefined, @Req() request: RequestUser) {
    return this.energy.tasks(request.user.gesId || gesId);
  }

  @RequirePermissions("AUDIT_VIEW")
  @Get("audit")
  audit(@Query("entity") entity?: string) {
    return this.energy.listAudit(entity);
  }

  @RequirePermissions("AUDIT_VIEW")
  @Get("users")
  users() {
    return this.energy.users();
  }

  @RequirePermissions("AUDIT_VIEW")
  @Get("roles")
  roles() {
    return this.energy.roles();
  }
}
