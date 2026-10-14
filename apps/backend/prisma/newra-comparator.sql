--
-- PostgreSQL database dump
--

-- Dumped from database version 16.15
-- Dumped by pg_dump version 16.15

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public."User" DROP CONSTRAINT IF EXISTS "User_gesId_fkey";
ALTER TABLE IF EXISTS ONLY public."UserRole" DROP CONSTRAINT IF EXISTS "UserRole_userId_fkey";
ALTER TABLE IF EXISTS ONLY public."UserRole" DROP CONSTRAINT IF EXISTS "UserRole_roleId_fkey";
ALTER TABLE IF EXISTS ONLY public."Task" DROP CONSTRAINT IF EXISTS "Task_ownerId_fkey";
ALTER TABLE IF EXISTS ONLY public."Task" DROP CONSTRAINT IF EXISTS "Task_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."Task" DROP CONSTRAINT IF EXISTS "Task_gesId_fkey";
ALTER TABLE IF EXISTS ONLY public."TariffNegotiation" DROP CONSTRAINT IF EXISTS "TariffNegotiation_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."TariffNegotiation" DROP CONSTRAINT IF EXISTS "TariffNegotiation_gesId_fkey";
ALTER TABLE IF EXISTS ONLY public."RolePermission" DROP CONSTRAINT IF EXISTS "RolePermission_roleId_fkey";
ALTER TABLE IF EXISTS ONLY public."RolePermission" DROP CONSTRAINT IF EXISTS "RolePermission_permissionId_fkey";
ALTER TABLE IF EXISTS ONLY public."RefreshToken" DROP CONSTRAINT IF EXISTS "RefreshToken_userId_fkey";
ALTER TABLE IF EXISTS ONLY public."RedFlag" DROP CONSTRAINT IF EXISTS "RedFlag_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."RedFlag" DROP CONSTRAINT IF EXISTS "RedFlag_gesId_fkey";
ALTER TABLE IF EXISTS ONLY public."QuestionnaireAnswer" DROP CONSTRAINT IF EXISTS "QuestionnaireAnswer_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."QuestionnaireAnswer" DROP CONSTRAINT IF EXISTS "QuestionnaireAnswer_gesId_fkey";
ALTER TABLE IF EXISTS ONLY public."Psoa" DROP CONSTRAINT IF EXISTS "Psoa_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."Psoa" DROP CONSTRAINT IF EXISTS "Psoa_gesId_fkey";
ALTER TABLE IF EXISTS ONLY public."Negotiation" DROP CONSTRAINT IF EXISTS "Negotiation_selectionId_fkey";
ALTER TABLE IF EXISTS ONLY public."Negotiation" DROP CONSTRAINT IF EXISTS "Negotiation_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."Negotiation" DROP CONSTRAINT IF EXISTS "Negotiation_gesId_fkey";
ALTER TABLE IF EXISTS ONLY public."NegotiationOffer" DROP CONSTRAINT IF EXISTS "NegotiationOffer_negotiationId_fkey";
ALTER TABLE IF EXISTS ONLY public."NegotiationOffer" DROP CONSTRAINT IF EXISTS "NegotiationOffer_createdById_fkey";
ALTER TABLE IF EXISTS ONLY public."LoginOtp" DROP CONSTRAINT IF EXISTS "LoginOtp_userId_fkey";
ALTER TABLE IF EXISTS ONLY public."LoadMatchResult" DROP CONSTRAINT IF EXISTS "LoadMatchResult_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."LoadMatchResult" DROP CONSTRAINT IF EXISTS "LoadMatchResult_gesId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPWindProfile" DROP CONSTRAINT IF EXISTS "IPPWindProfile_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPTechnology" DROP CONSTRAINT IF EXISTS "IPPTechnology_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPTariffScenario" DROP CONSTRAINT IF EXISTS "IPPTariffScenario_modelId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPTariffModel" DROP CONSTRAINT IF EXISTS "IPPTariffModel_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPTariffComponent" DROP CONSTRAINT IF EXISTS "IPPTariffComponent_modelId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPSuitability" DROP CONSTRAINT IF EXISTS "IPPSuitability_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPSuitability" DROP CONSTRAINT IF EXISTS "IPPSuitability_gesRequirementId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPSolarProfile" DROP CONSTRAINT IF EXISTS "IPPSolarProfile_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPRegulatoryProfile" DROP CONSTRAINT IF EXISTS "IPPRegulatoryProfile_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPProject" DROP CONSTRAINT IF EXISTS "IPPProject_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPGenerationProfile" DROP CONSTRAINT IF EXISTS "IPPGenerationProfile_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPFinancialModel" DROP CONSTRAINT IF EXISTS "IPPFinancialModel_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPExperience" DROP CONSTRAINT IF EXISTS "IPPExperience_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPExecutionSchedule" DROP CONSTRAINT IF EXISTS "IPPExecutionSchedule_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPEvaluation" DROP CONSTRAINT IF EXISTS "IPPEvaluation_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPEvaluationScore" DROP CONSTRAINT IF EXISTS "IPPEvaluationScore_evaluationId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPEvaluationParameter" DROP CONSTRAINT IF EXISTS "IPPEvaluationParameter_evaluationId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPEPCProfile" DROP CONSTRAINT IF EXISTS "IPPEPCProfile_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPEHVProfile" DROP CONSTRAINT IF EXISTS "IPPEHVProfile_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPCapexModel" DROP CONSTRAINT IF EXISTS "IPPCapexModel_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPCapexItem" DROP CONSTRAINT IF EXISTS "IPPCapexItem_modelId_fkey";
ALTER TABLE IF EXISTS ONLY public."IPPBESSProfile" DROP CONSTRAINT IF EXISTS "IPPBESSProfile_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."GESRequirement" DROP CONSTRAINT IF EXISTS "GESRequirement_gesId_fkey";
ALTER TABLE IF EXISTS ONLY public."GESRequirementIPP" DROP CONSTRAINT IF EXISTS "GESRequirementIPP_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."GESRequirementIPP" DROP CONSTRAINT IF EXISTS "GESRequirementIPP_gesRequirementId_fkey";
ALTER TABLE IF EXISTS ONLY public."GESLoadProfile" DROP CONSTRAINT IF EXISTS "GESLoadProfile_gesId_fkey";
ALTER TABLE IF EXISTS ONLY public."GESIPPSelection" DROP CONSTRAINT IF EXISTS "GESIPPSelection_updatedById_fkey";
ALTER TABLE IF EXISTS ONLY public."GESIPPSelection" DROP CONSTRAINT IF EXISTS "GESIPPSelection_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."GESIPPSelection" DROP CONSTRAINT IF EXISTS "GESIPPSelection_gesRequirementId_fkey";
ALTER TABLE IF EXISTS ONLY public."GESIPPSelection" DROP CONSTRAINT IF EXISTS "GESIPPSelection_gesId_fkey";
ALTER TABLE IF EXISTS ONLY public."GESIPPSelection" DROP CONSTRAINT IF EXISTS "GESIPPSelection_createdById_fkey";
ALTER TABLE IF EXISTS ONLY public."GESConsumer" DROP CONSTRAINT IF EXISTS "GESConsumer_gesId_fkey";
ALTER TABLE IF EXISTS ONLY public."Document" DROP CONSTRAINT IF EXISTS "Document_ownerId_fkey";
ALTER TABLE IF EXISTS ONLY public."Document" DROP CONSTRAINT IF EXISTS "Document_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."Document" DROP CONSTRAINT IF EXISTS "Document_gesId_fkey";
ALTER TABLE IF EXISTS ONLY public."DocumentVersion" DROP CONSTRAINT IF EXISTS "DocumentVersion_documentId_fkey";
ALTER TABLE IF EXISTS ONLY public."Dealbook" DROP CONSTRAINT IF EXISTS "Dealbook_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."Dealbook" DROP CONSTRAINT IF EXISTS "Dealbook_gesId_fkey";
ALTER TABLE IF EXISTS ONLY public."CriticalGateResult" DROP CONSTRAINT IF EXISTS "CriticalGateResult_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."CriticalGateResult" DROP CONSTRAINT IF EXISTS "CriticalGateResult_gesId_fkey";
ALTER TABLE IF EXISTS ONLY public."CriticalGateResult" DROP CONSTRAINT IF EXISTS "CriticalGateResult_gateId_fkey";
ALTER TABLE IF EXISTS ONLY public."Comparison" DROP CONSTRAINT IF EXISTS "Comparison_gesId_fkey";
ALTER TABLE IF EXISTS ONLY public."ComparisonIPP" DROP CONSTRAINT IF EXISTS "ComparisonIPP_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."ComparisonIPP" DROP CONSTRAINT IF EXISTS "ComparisonIPP_comparisonId_fkey";
ALTER TABLE IF EXISTS ONLY public."CommercialRequirement" DROP CONSTRAINT IF EXISTS "CommercialRequirement_selectionId_fkey";
ALTER TABLE IF EXISTS ONLY public."CommercialRequirement" DROP CONSTRAINT IF EXISTS "CommercialRequirement_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."CommercialRequirement" DROP CONSTRAINT IF EXISTS "CommercialRequirement_gesId_fkey";
ALTER TABLE IF EXISTS ONLY public."CommercialRequirement" DROP CONSTRAINT IF EXISTS "CommercialRequirement_createdById_fkey";
ALTER TABLE IF EXISTS ONLY public."AuditLog" DROP CONSTRAINT IF EXISTS "AuditLog_userId_fkey";
ALTER TABLE IF EXISTS ONLY public."Activity" DROP CONSTRAINT IF EXISTS "Activity_ippId_fkey";
ALTER TABLE IF EXISTS ONLY public."Activity" DROP CONSTRAINT IF EXISTS "Activity_gesId_fkey";
ALTER TABLE IF EXISTS ONLY public."Activity" DROP CONSTRAINT IF EXISTS "Activity_actorId_fkey";
DROP INDEX IF EXISTS public."User_email_key";
DROP INDEX IF EXISTS public."TariffNegotiation_gesId_ippId_key";
DROP INDEX IF EXISTS public."Role_name_key";
DROP INDEX IF EXISTS public."RefreshToken_userId_idx";
DROP INDEX IF EXISTS public."RedFlag_ippId_gesId_idx";
DROP INDEX IF EXISTS public."QuestionnaireAnswer_gesId_ippId_questionKey_key";
DROP INDEX IF EXISTS public."QuestionnaireAnswer_gesId_ippId_idx";
DROP INDEX IF EXISTS public."Psoa_gesId_ippId_key";
DROP INDEX IF EXISTS public."Permission_key_key";
DROP INDEX IF EXISTS public."Negotiation_selectionId_key";
DROP INDEX IF EXISTS public."Negotiation_gesId_ippId_key";
DROP INDEX IF EXISTS public."NegotiationOffer_negotiationId_version_key";
DROP INDEX IF EXISTS public."LoginOtp_userId_idx";
DROP INDEX IF EXISTS public."LoadMatchResult_gesId_ippId_key";
DROP INDEX IF EXISTS public."IPPWindProfile_ippId_key";
DROP INDEX IF EXISTS public."IPPTechnology_ippId_key";
DROP INDEX IF EXISTS public."IPPTariffModel_ippId_key";
DROP INDEX IF EXISTS public."IPPSuitability_gesRequirementId_ippId_key";
DROP INDEX IF EXISTS public."IPPSolarProfile_ippId_key";
DROP INDEX IF EXISTS public."IPPRegulatoryProfile_ippId_key";
DROP INDEX IF EXISTS public."IPPProject_ippId_key";
DROP INDEX IF EXISTS public."IPPGenerationProfile_ippId_key";
DROP INDEX IF EXISTS public."IPPFinancialModel_ippId_key";
DROP INDEX IF EXISTS public."IPPExperience_ippId_key";
DROP INDEX IF EXISTS public."IPPExecutionSchedule_ippId_key";
DROP INDEX IF EXISTS public."IPPEvaluation_ippId_key";
DROP INDEX IF EXISTS public."IPPEvaluationScore_evaluationId_key_key";
DROP INDEX IF EXISTS public."IPPEvaluationParameter_evaluationId_key_key";
DROP INDEX IF EXISTS public."IPPEPCProfile_ippId_key";
DROP INDEX IF EXISTS public."IPPEHVProfile_ippId_key";
DROP INDEX IF EXISTS public."IPPCapexModel_ippId_key";
DROP INDEX IF EXISTS public."IPPBESSProfile_ippId_key";
DROP INDEX IF EXISTS public."GESRequirement_gesId_key";
DROP INDEX IF EXISTS public."GESRequirementIPP_gesRequirementId_ippId_key";
DROP INDEX IF EXISTS public."GESIPPSelection_gesRequirementId_idx";
DROP INDEX IF EXISTS public."GESIPPSelection_gesId_ippId_key";
DROP INDEX IF EXISTS public."Dealbook_gesId_ippId_key";
DROP INDEX IF EXISTS public."CriticalGate_key_key";
DROP INDEX IF EXISTS public."CriticalGateResult_gateId_ippId_gesId_key";
DROP INDEX IF EXISTS public."Comparison_gesId_working_idx";
DROP INDEX IF EXISTS public."CommercialRequirement_selectionId_createdAt_idx";
DROP INDEX IF EXISTS public."CommercialRequirement_gesId_ippId_idx";
DROP INDEX IF EXISTS public."AuditLog_entity_entityId_idx";
ALTER TABLE IF EXISTS ONLY public."User" DROP CONSTRAINT IF EXISTS "User_pkey";
ALTER TABLE IF EXISTS ONLY public."UserRole" DROP CONSTRAINT IF EXISTS "UserRole_pkey";
ALTER TABLE IF EXISTS ONLY public."Task" DROP CONSTRAINT IF EXISTS "Task_pkey";
ALTER TABLE IF EXISTS ONLY public."TariffNegotiation" DROP CONSTRAINT IF EXISTS "TariffNegotiation_pkey";
ALTER TABLE IF EXISTS ONLY public."SuitabilityConfig" DROP CONSTRAINT IF EXISTS "SuitabilityConfig_pkey";
ALTER TABLE IF EXISTS ONLY public."Role" DROP CONSTRAINT IF EXISTS "Role_pkey";
ALTER TABLE IF EXISTS ONLY public."RolePermission" DROP CONSTRAINT IF EXISTS "RolePermission_pkey";
ALTER TABLE IF EXISTS ONLY public."RefreshToken" DROP CONSTRAINT IF EXISTS "RefreshToken_pkey";
ALTER TABLE IF EXISTS ONLY public."RedFlag" DROP CONSTRAINT IF EXISTS "RedFlag_pkey";
ALTER TABLE IF EXISTS ONLY public."QuestionnaireAnswer" DROP CONSTRAINT IF EXISTS "QuestionnaireAnswer_pkey";
ALTER TABLE IF EXISTS ONLY public."Psoa" DROP CONSTRAINT IF EXISTS "Psoa_pkey";
ALTER TABLE IF EXISTS ONLY public."Permission" DROP CONSTRAINT IF EXISTS "Permission_pkey";
ALTER TABLE IF EXISTS ONLY public."Negotiation" DROP CONSTRAINT IF EXISTS "Negotiation_pkey";
ALTER TABLE IF EXISTS ONLY public."NegotiationOffer" DROP CONSTRAINT IF EXISTS "NegotiationOffer_pkey";
ALTER TABLE IF EXISTS ONLY public."LoginOtp" DROP CONSTRAINT IF EXISTS "LoginOtp_pkey";
ALTER TABLE IF EXISTS ONLY public."LoadMatchResult" DROP CONSTRAINT IF EXISTS "LoadMatchResult_pkey";
ALTER TABLE IF EXISTS ONLY public."IPP" DROP CONSTRAINT IF EXISTS "IPP_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPWindProfile" DROP CONSTRAINT IF EXISTS "IPPWindProfile_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPTechnology" DROP CONSTRAINT IF EXISTS "IPPTechnology_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPTariffScenario" DROP CONSTRAINT IF EXISTS "IPPTariffScenario_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPTariffModel" DROP CONSTRAINT IF EXISTS "IPPTariffModel_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPTariffComponent" DROP CONSTRAINT IF EXISTS "IPPTariffComponent_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPSuitability" DROP CONSTRAINT IF EXISTS "IPPSuitability_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPSolarProfile" DROP CONSTRAINT IF EXISTS "IPPSolarProfile_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPRegulatoryProfile" DROP CONSTRAINT IF EXISTS "IPPRegulatoryProfile_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPProject" DROP CONSTRAINT IF EXISTS "IPPProject_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPGenerationProfile" DROP CONSTRAINT IF EXISTS "IPPGenerationProfile_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPFinancialModel" DROP CONSTRAINT IF EXISTS "IPPFinancialModel_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPExperience" DROP CONSTRAINT IF EXISTS "IPPExperience_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPExecutionSchedule" DROP CONSTRAINT IF EXISTS "IPPExecutionSchedule_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPEvaluation" DROP CONSTRAINT IF EXISTS "IPPEvaluation_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPEvaluationScore" DROP CONSTRAINT IF EXISTS "IPPEvaluationScore_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPEvaluationParameter" DROP CONSTRAINT IF EXISTS "IPPEvaluationParameter_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPEPCProfile" DROP CONSTRAINT IF EXISTS "IPPEPCProfile_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPEHVProfile" DROP CONSTRAINT IF EXISTS "IPPEHVProfile_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPCapexModel" DROP CONSTRAINT IF EXISTS "IPPCapexModel_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPCapexItem" DROP CONSTRAINT IF EXISTS "IPPCapexItem_pkey";
ALTER TABLE IF EXISTS ONLY public."IPPBESSProfile" DROP CONSTRAINT IF EXISTS "IPPBESSProfile_pkey";
ALTER TABLE IF EXISTS ONLY public."GES" DROP CONSTRAINT IF EXISTS "GES_pkey";
ALTER TABLE IF EXISTS ONLY public."GESRequirement" DROP CONSTRAINT IF EXISTS "GESRequirement_pkey";
ALTER TABLE IF EXISTS ONLY public."GESRequirementIPP" DROP CONSTRAINT IF EXISTS "GESRequirementIPP_pkey";
ALTER TABLE IF EXISTS ONLY public."GESLoadProfile" DROP CONSTRAINT IF EXISTS "GESLoadProfile_pkey";
ALTER TABLE IF EXISTS ONLY public."GESIPPSelection" DROP CONSTRAINT IF EXISTS "GESIPPSelection_pkey";
ALTER TABLE IF EXISTS ONLY public."GESConsumer" DROP CONSTRAINT IF EXISTS "GESConsumer_pkey";
ALTER TABLE IF EXISTS ONLY public."Document" DROP CONSTRAINT IF EXISTS "Document_pkey";
ALTER TABLE IF EXISTS ONLY public."DocumentVersion" DROP CONSTRAINT IF EXISTS "DocumentVersion_pkey";
ALTER TABLE IF EXISTS ONLY public."Dealbook" DROP CONSTRAINT IF EXISTS "Dealbook_pkey";
ALTER TABLE IF EXISTS ONLY public."CriticalGate" DROP CONSTRAINT IF EXISTS "CriticalGate_pkey";
ALTER TABLE IF EXISTS ONLY public."CriticalGateResult" DROP CONSTRAINT IF EXISTS "CriticalGateResult_pkey";
ALTER TABLE IF EXISTS ONLY public."Comparison" DROP CONSTRAINT IF EXISTS "Comparison_pkey";
ALTER TABLE IF EXISTS ONLY public."ComparisonIPP" DROP CONSTRAINT IF EXISTS "ComparisonIPP_pkey";
ALTER TABLE IF EXISTS ONLY public."CommercialRequirement" DROP CONSTRAINT IF EXISTS "CommercialRequirement_pkey";
ALTER TABLE IF EXISTS ONLY public."AuditLog" DROP CONSTRAINT IF EXISTS "AuditLog_pkey";
ALTER TABLE IF EXISTS ONLY public."Activity" DROP CONSTRAINT IF EXISTS "Activity_pkey";
DROP TABLE IF EXISTS public."UserRole";
DROP TABLE IF EXISTS public."User";
DROP TABLE IF EXISTS public."Task";
DROP TABLE IF EXISTS public."TariffNegotiation";
DROP TABLE IF EXISTS public."SuitabilityConfig";
DROP TABLE IF EXISTS public."RolePermission";
DROP TABLE IF EXISTS public."Role";
DROP TABLE IF EXISTS public."RefreshToken";
DROP TABLE IF EXISTS public."RedFlag";
DROP TABLE IF EXISTS public."QuestionnaireAnswer";
DROP TABLE IF EXISTS public."Psoa";
DROP TABLE IF EXISTS public."Permission";
DROP TABLE IF EXISTS public."NegotiationOffer";
DROP TABLE IF EXISTS public."Negotiation";
DROP TABLE IF EXISTS public."LoginOtp";
DROP TABLE IF EXISTS public."LoadMatchResult";
DROP TABLE IF EXISTS public."IPPWindProfile";
DROP TABLE IF EXISTS public."IPPTechnology";
DROP TABLE IF EXISTS public."IPPTariffScenario";
DROP TABLE IF EXISTS public."IPPTariffModel";
DROP TABLE IF EXISTS public."IPPTariffComponent";
DROP TABLE IF EXISTS public."IPPSuitability";
DROP TABLE IF EXISTS public."IPPSolarProfile";
DROP TABLE IF EXISTS public."IPPRegulatoryProfile";
DROP TABLE IF EXISTS public."IPPProject";
DROP TABLE IF EXISTS public."IPPGenerationProfile";
DROP TABLE IF EXISTS public."IPPFinancialModel";
DROP TABLE IF EXISTS public."IPPExperience";
DROP TABLE IF EXISTS public."IPPExecutionSchedule";
DROP TABLE IF EXISTS public."IPPEvaluationScore";
DROP TABLE IF EXISTS public."IPPEvaluationParameter";
DROP TABLE IF EXISTS public."IPPEvaluation";
DROP TABLE IF EXISTS public."IPPEPCProfile";
DROP TABLE IF EXISTS public."IPPEHVProfile";
DROP TABLE IF EXISTS public."IPPCapexModel";
DROP TABLE IF EXISTS public."IPPCapexItem";
DROP TABLE IF EXISTS public."IPPBESSProfile";
DROP TABLE IF EXISTS public."IPP";
DROP TABLE IF EXISTS public."GESRequirementIPP";
DROP TABLE IF EXISTS public."GESRequirement";
DROP TABLE IF EXISTS public."GESLoadProfile";
DROP TABLE IF EXISTS public."GESIPPSelection";
DROP TABLE IF EXISTS public."GESConsumer";
DROP TABLE IF EXISTS public."GES";
DROP TABLE IF EXISTS public."DocumentVersion";
DROP TABLE IF EXISTS public."Document";
DROP TABLE IF EXISTS public."Dealbook";
DROP TABLE IF EXISTS public."CriticalGateResult";
DROP TABLE IF EXISTS public."CriticalGate";
DROP TABLE IF EXISTS public."ComparisonIPP";
DROP TABLE IF EXISTS public."Comparison";
DROP TABLE IF EXISTS public."CommercialRequirement";
DROP TABLE IF EXISTS public."AuditLog";
DROP TABLE IF EXISTS public."Activity";
DROP TYPE IF EXISTS public."TaskStatus";
DROP TYPE IF EXISTS public."TaskPriority";
DROP TYPE IF EXISTS public."TariffSustainability";
DROP TYPE IF EXISTS public."RoleName";
DROP TYPE IF EXISTS public."RedFlagSeverity";
DROP TYPE IF EXISTS public."RedFlagCategory";
DROP TYPE IF EXISTS public."PsoaItemStatus";
DROP TYPE IF EXISTS public."PermissionKey";
DROP TYPE IF EXISTS public."OfferType";
DROP TYPE IF EXISTS public."OfferStatus";
DROP TYPE IF EXISTS public."GesIppSelectionStatus";
DROP TYPE IF EXISTS public."GesAccessStatus";
DROP TYPE IF EXISTS public."GateStatus";
DROP TYPE IF EXISTS public."EvaluationStage";
DROP TYPE IF EXISTS public."DocumentStatus";
DROP TYPE IF EXISTS public."DocumentCategory";
DROP TYPE IF EXISTS public."DataQuality";
DROP TYPE IF EXISTS public."CrmStage";
DROP TYPE IF EXISTS public."ConnectivityStatus";
DROP TYPE IF EXISTS public."CompatibilityStatus";
DROP TYPE IF EXISTS public."CommercialRequirementStatus";
DROP TYPE IF EXISTS public."BessPreference";
DROP TYPE IF EXISTS public."AssumptionType";
--
-- Name: AssumptionType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."AssumptionType" AS ENUM (
    'FIRM',
    'QUOTATION_SUPPORTED',
    'INDICATIVE',
    'BUDGETARY'
);


--
-- Name: BessPreference; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."BessPreference" AS ENUM (
    'OPTIONAL',
    'HOURS_2_TO_4',
    'HOURS_4'
);


--
-- Name: CommercialRequirementStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."CommercialRequirementStatus" AS ENUM (
    'SUBMITTED',
    'UPDATED'
);


--
-- Name: CompatibilityStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."CompatibilityStatus" AS ENUM (
    'HIGHLY_SUITABLE',
    'SUITABLE',
    'CONDITIONAL',
    'NOT_SUITABLE',
    'GATE_FAILED'
);


--
-- Name: ConnectivityStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ConnectivityStatus" AS ENUM (
    'PRELIMINARY',
    'UNDER_STUDY',
    'APPLICATION_SUBMITTED',
    'APPROVAL_PENDING',
    'APPROVED'
);


--
-- Name: CrmStage; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."CrmStage" AS ENUM (
    'CLIENT_DISCOVERY',
    'INTRODUCTION',
    'ELECTRICITY_BILLS',
    'NRG_ANALYSIS',
    'LOI',
    'NRG_SYMPHONY',
    'NDA_TC',
    'ANNEXURE_B_PPA_DRAFT',
    'FINALIZATION',
    'PPA_SIGNING',
    'PHASE_3_GO_LIVE'
);


--
-- Name: DataQuality; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."DataQuality" AS ENUM (
    'COMPLETE',
    'PARTIAL',
    'MISSING',
    'UNVERIFIED'
);


--
-- Name: DocumentCategory; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."DocumentCategory" AS ENUM (
    'IPP_COMPANY_PROFILE',
    'PROJECT_DETAILS',
    'COD_CERTIFICATES',
    'GENERATION_REPORTS',
    'P50_P75_P90',
    'EHV_DOCUMENTS',
    'TECHNICAL_DOCUMENTS',
    'BESS_DOCUMENTS',
    'CAPEX_DOCUMENTS',
    'FINANCIAL_DOCUMENTS',
    'TARIFF_PROPOSAL',
    'PPA_DRAFT',
    'REGULATORY_DOCUMENTS',
    'CLIENT_REFERENCES',
    'APPROVALS'
);


--
-- Name: DocumentStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."DocumentStatus" AS ENUM (
    'REQUESTED',
    'PENDING',
    'RECEIVED',
    'UNDER_REVIEW',
    'VERIFIED',
    'REJECTED',
    'EXPIRED'
);


--
-- Name: EvaluationStage; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."EvaluationStage" AS ENUM (
    'IPP_EVALUATION',
    'IPP_SHORTLISTING',
    'NEGOTIATION',
    'PSOA',
    'DEALBOOK'
);


--
-- Name: GateStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."GateStatus" AS ENUM (
    'PASS',
    'CONDITIONAL',
    'FAIL'
);


--
-- Name: GesAccessStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."GesAccessStatus" AS ENUM (
    'PENDING',
    'APPROVED',
    'REJECTED'
);


--
-- Name: GesIppSelectionStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."GesIppSelectionStatus" AS ENUM (
    'CONSIDERED',
    'UNDER_REVIEW',
    'SELECTED',
    'COMMERCIAL_DISCUSSION',
    'CLOSED'
);


--
-- Name: OfferStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."OfferStatus" AS ENUM (
    'OPEN',
    'SUPERSEDED',
    'ACCEPTED',
    'REJECTED',
    'REVISED'
);


--
-- Name: OfferType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."OfferType" AS ENUM (
    'IPP_OFFER',
    'COUNTER_OFFER',
    'IPP_RESPONSE',
    'ACCEPTED',
    'REJECTED',
    'REVISED'
);


--
-- Name: PermissionKey; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."PermissionKey" AS ENUM (
    'IPP_VIEW',
    'IPP_CREATE',
    'IPP_EDIT',
    'GES_VIEW',
    'GES_CREATE',
    'GES_EDIT',
    'EVALUATION_VIEW',
    'EVALUATION_EDIT',
    'TECHNICAL_REVIEW',
    'FINANCIAL_REVIEW',
    'COMMERCIAL_REVIEW',
    'TARIFF_REVIEW',
    'NEGOTIATION_CREATE',
    'NEGOTIATION_APPROVE',
    'PSOA_VIEW',
    'PSOA_CREATE',
    'DEALBOOK_VIEW',
    'DEALBOOK_CREATE',
    'DOCUMENT_VIEW',
    'DOCUMENT_UPLOAD',
    'AUDIT_VIEW',
    'GES_PROFILE_EDIT',
    'REQUIREMENT_VIEW',
    'REQUIREMENT_EDIT',
    'SELECTION_VIEW',
    'SELECTION_CREATE',
    'COMMERCIAL_REQUIREMENT_VIEW',
    'COMMERCIAL_REQUIREMENT_CREATE'
);


--
-- Name: PsoaItemStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."PsoaItemStatus" AS ENUM (
    'PENDING',
    'RECEIVED',
    'VERIFIED',
    'EXCEPTION'
);


--
-- Name: RedFlagCategory; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."RedFlagCategory" AS ENUM (
    'TECHNICAL',
    'EXECUTION',
    'FINANCIAL',
    'PRICING',
    'REGULATORY'
);


--
-- Name: RedFlagSeverity; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."RedFlagSeverity" AS ENUM (
    'LOW',
    'MEDIUM',
    'HIGH',
    'CRITICAL'
);


--
-- Name: RoleName; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."RoleName" AS ENUM (
    'ADMIN',
    'EVALUATOR',
    'COMMERCIAL_REVIEWER',
    'TECHNICAL_REVIEWER',
    'FINANCE_REVIEWER',
    'VIEWER',
    'GES_USER',
    'NEWRA_ADMIN',
    'GES_ADMIN'
);


--
-- Name: TariffSustainability; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."TariffSustainability" AS ENUM (
    'SUSTAINABLE',
    'AGGRESSIVE',
    'UNSUSTAINABLE'
);


--
-- Name: TaskPriority; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."TaskPriority" AS ENUM (
    'LOW',
    'MEDIUM',
    'HIGH',
    'CRITICAL'
);


--
-- Name: TaskStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."TaskStatus" AS ENUM (
    'OPEN',
    'IN_PROGRESS',
    'DONE',
    'BLOCKED'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Activity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Activity" (
    id text NOT NULL,
    "gesId" text,
    "ippId" text,
    message text NOT NULL,
    "actorId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: AuditLog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AuditLog" (
    id text NOT NULL,
    entity text NOT NULL,
    "entityId" text NOT NULL,
    action text NOT NULL,
    "oldValue" jsonb,
    "newValue" jsonb,
    "userId" text,
    "requestId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: CommercialRequirement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CommercialRequirement" (
    id text NOT NULL,
    "selectionId" text NOT NULL,
    "gesId" text NOT NULL,
    "ippId" text NOT NULL,
    "targetTariffInrPerKwh" double precision,
    "requiredEnergyGwh" double precision,
    "requiredLoadMw" double precision,
    "contractTenureYears" double precision,
    "targetSupplyYear" integer,
    notes text DEFAULT ''::text NOT NULL,
    status public."CommercialRequirementStatus" NOT NULL,
    "createdById" text,
    "createdByRole" text DEFAULT ''::text NOT NULL,
    "actingOnBehalfOfGes" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: Comparison; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Comparison" (
    id text NOT NULL,
    "gesId" text NOT NULL,
    name text NOT NULL,
    "createdById" text,
    working boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: ComparisonIPP; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."ComparisonIPP" (
    "comparisonId" text NOT NULL,
    "ippId" text NOT NULL,
    "position" integer NOT NULL
);


--
-- Name: CriticalGate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CriticalGate" (
    id text NOT NULL,
    key text NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    "sortOrder" integer NOT NULL
);


--
-- Name: CriticalGateResult; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CriticalGateResult" (
    id text NOT NULL,
    "gateId" text NOT NULL,
    "ippId" text NOT NULL,
    "gesId" text NOT NULL,
    status public."GateStatus" NOT NULL,
    rationale text NOT NULL,
    evidence text NOT NULL
);


--
-- Name: Dealbook; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Dealbook" (
    id text NOT NULL,
    "gesId" text NOT NULL,
    "ippId" text NOT NULL,
    recommendation text NOT NULL,
    conditions text NOT NULL,
    summary jsonb NOT NULL,
    approvals jsonb NOT NULL,
    illustrative boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Document; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Document" (
    id text NOT NULL,
    "gesId" text,
    "ippId" text,
    category public."DocumentCategory" NOT NULL,
    title text NOT NULL,
    status public."DocumentStatus" NOT NULL,
    "ownerId" text,
    "pendingFrom" text NOT NULL,
    location text NOT NULL,
    comments text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: DocumentVersion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."DocumentVersion" (
    id text NOT NULL,
    "documentId" text NOT NULL,
    version integer NOT NULL,
    "sentDate" timestamp(3) without time zone,
    "receivedDate" timestamp(3) without time zone,
    "signedDate" timestamp(3) without time zone,
    notes text NOT NULL
);


--
-- Name: GES; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."GES" (
    id text NOT NULL,
    name text NOT NULL,
    "legalName" text NOT NULL,
    "businessType" text NOT NULL,
    location text NOT NULL,
    state text NOT NULL,
    discom text NOT NULL,
    "consumerNumbers" text NOT NULL,
    "contractDemandMw" double precision NOT NULL,
    "billedDemandMw" double precision NOT NULL,
    "existingRooftopMw" double precision NOT NULL,
    "existingRenewableGwh" double precision NOT NULL,
    "annualConsumptionGwh" double precision NOT NULL,
    notes text NOT NULL,
    illustrative boolean DEFAULT true NOT NULL,
    "crmStage" public."CrmStage" NOT NULL,
    "evaluationStage" public."EvaluationStage" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "renewableEnergyTargetPercent" double precision,
    "sanctionedLoadKw" double precision,
    "solarConnectionType" text,
    "peakRecordedDemandKva" double precision,
    "bessRequirement" text,
    "contactEmail" text DEFAULT ''::text NOT NULL,
    "contactName" text DEFAULT ''::text NOT NULL,
    "contactPhone" text DEFAULT ''::text NOT NULL,
    "fieldProvenance" jsonb,
    "plantAddress" text DEFAULT ''::text NOT NULL,
    "zoneConsumption" jsonb
);


--
-- Name: GESConsumer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."GESConsumer" (
    id text NOT NULL,
    "gesId" text NOT NULL,
    "consumerNumber" text NOT NULL,
    discom text NOT NULL,
    "contractDemandMw" double precision NOT NULL,
    "billedDemandMw" double precision NOT NULL,
    "voltageLevel" text NOT NULL
);


--
-- Name: GESIPPSelection; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."GESIPPSelection" (
    id text NOT NULL,
    "gesId" text NOT NULL,
    "ippId" text NOT NULL,
    "gesRequirementId" text NOT NULL,
    status public."GesIppSelectionStatus" DEFAULT 'CONSIDERED'::public."GesIppSelectionStatus" NOT NULL,
    "createdById" text,
    "createdByRole" text DEFAULT ''::text NOT NULL,
    "actingOnBehalfOfGes" boolean DEFAULT false NOT NULL,
    "updatedById" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: GESLoadProfile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."GESLoadProfile" (
    id text NOT NULL,
    "gesId" text NOT NULL,
    name text NOT NULL,
    "intervalMinutes" integer DEFAULT 15 NOT NULL,
    intervals jsonb NOT NULL,
    "annualEnergyGwh" double precision NOT NULL,
    "peakMw" double precision NOT NULL,
    "dataQuality" public."DataQuality" NOT NULL,
    source text NOT NULL,
    "evidenceStatus" public."DocumentStatus" NOT NULL,
    illustrative boolean DEFAULT true NOT NULL
);


--
-- Name: GESRequirement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."GESRequirement" (
    id text NOT NULL,
    "gesId" text NOT NULL,
    "annualEnergyGwh" double precision NOT NULL,
    "peakDemandMw" double precision NOT NULL,
    "requiredCapacityGw" double precision NOT NULL,
    "targetCodYear" integer NOT NULL,
    "preferredTechnologies" text[],
    "bessPreference" public."BessPreference" NOT NULL,
    "bessHoursMin" double precision,
    "bessHoursMax" double precision,
    notes text NOT NULL,
    "dataQuality" public."DataQuality" NOT NULL,
    illustrative boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "commercialNotes" text DEFAULT ''::text NOT NULL,
    "contractTenureYears" double precision,
    "renewableTargetPercent" double precision,
    "requiredRenewableGwh" double precision,
    "targetTariffInrPerKwh" double precision
);


--
-- Name: GESRequirementIPP; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."GESRequirementIPP" (
    id text NOT NULL,
    "gesRequirementId" text NOT NULL,
    "ippId" text NOT NULL,
    "compatibilityStatus" public."CompatibilityStatus" NOT NULL,
    "illustrativeSeedStatus" public."CompatibilityStatus" NOT NULL,
    "suitabilityScore" double precision DEFAULT 0 NOT NULL,
    "technicalFit" double precision DEFAULT 0 NOT NULL,
    "commercialFit" double precision DEFAULT 0 NOT NULL,
    "financialFit" double precision DEFAULT 0 NOT NULL,
    "generationFit" double precision DEFAULT 0 NOT NULL,
    "loadMatchScore" double precision DEFAULT 0 NOT NULL,
    shortlisted boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: IPP; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPP" (
    id text NOT NULL,
    name text NOT NULL,
    "legalName" text NOT NULL,
    headquarters text NOT NULL,
    "technologySummary" text NOT NULL,
    "solarMw" double precision NOT NULL,
    "windMw" double precision NOT NULL,
    "bessMw" double precision NOT NULL,
    "bessMwh" double precision NOT NULL,
    "annualGenerationGwh" double precision NOT NULL,
    "p90Gwh" double precision NOT NULL,
    "indicativeTariffInrPerKwh" double precision NOT NULL,
    "targetCodYear" integer NOT NULL,
    "evaluationStage" public."EvaluationStage" NOT NULL,
    "pendingFrom" text NOT NULL,
    illustrative boolean DEFAULT true NOT NULL,
    baseline jsonb NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "projectDistrict" text,
    "projectLocation" text,
    "generationData15Min" text,
    "fdreCapability" text,
    "gridVoltage" text,
    "gridConnectivity" text,
    "openAccessReadiness" text,
    "tariffType" text,
    "contractTenureYears" double precision,
    "codConfidence" text,
    "financialModelAvailable" text,
    "fundingStatus" text,
    cin text DEFAULT ''::text NOT NULL,
    "keyContact" text DEFAULT ''::text NOT NULL,
    leadership text DEFAULT ''::text NOT NULL,
    "loiScope" text DEFAULT ''::text NOT NULL,
    notes text DEFAULT ''::text NOT NULL,
    "portfolioCapacity" text DEFAULT ''::text NOT NULL,
    "referenceNo" text DEFAULT ''::text NOT NULL
);


--
-- Name: IPPBESSProfile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPBESSProfile" (
    id text NOT NULL,
    "ippId" text NOT NULL,
    "powerMw" double precision NOT NULL,
    "energyMwh" double precision NOT NULL,
    "usableEnergyMwh" double precision NOT NULL,
    "durationHours" double precision NOT NULL,
    chemistry text NOT NULL,
    oem text NOT NULL,
    pcs text NOT NULL,
    ems text NOT NULL,
    "roundTripEfficiency" double precision NOT NULL,
    "depthOfDischarge" double precision NOT NULL,
    "cycleCapability" integer NOT NULL,
    availability double precision NOT NULL,
    degradation double precision,
    augmentation text NOT NULL,
    "yearSnapshots" jsonb NOT NULL,
    "augmentationPayer" text NOT NULL,
    "dispatchOwner" text NOT NULL,
    "socMin" double precision NOT NULL,
    "socMax" double precision NOT NULL,
    warranty text NOT NULL,
    "performanceGuarantee" text NOT NULL,
    evidences jsonb NOT NULL,
    "dataQuality" public."DataQuality" NOT NULL
);


--
-- Name: IPPCapexItem; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPCapexItem" (
    id text NOT NULL,
    "modelId" text NOT NULL,
    category text NOT NULL,
    "amountInrCr" double precision NOT NULL,
    unit text NOT NULL,
    source text NOT NULL,
    evidence text NOT NULL,
    "assumptionType" public."AssumptionType" NOT NULL,
    "evidenceStatus" public."DocumentStatus" NOT NULL
);


--
-- Name: IPPCapexModel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPCapexModel" (
    id text NOT NULL,
    "ippId" text NOT NULL,
    "totalInrCr" double precision NOT NULL,
    "credibilityScore" double precision NOT NULL,
    "dataQuality" public."DataQuality" NOT NULL
);


--
-- Name: IPPEHVProfile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPEHVProfile" (
    id text NOT NULL,
    "ippId" text NOT NULL,
    "kv132Experience" boolean NOT NULL,
    "kv220Experience" boolean NOT NULL,
    "stuCoordination" text NOT NULL,
    "sldcCoordination" text NOT NULL,
    "discomCoordination" text NOT NULL,
    "systemStudies" text NOT NULL,
    bay text NOT NULL,
    pooling text NOT NULL,
    protection text NOT NULL,
    metering text NOT NULL,
    communication text NOT NULL,
    "rowStatus" text NOT NULL,
    "transmissionRouting" text NOT NULL,
    "connectivityStatus" public."ConnectivityStatus" NOT NULL,
    "capabilityScore" double precision NOT NULL,
    "connectivityRisk" text NOT NULL,
    "evidenceStatus" public."DocumentStatus" NOT NULL,
    evidences jsonb NOT NULL,
    "dataQuality" public."DataQuality" NOT NULL
);


--
-- Name: IPPEPCProfile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPEPCProfile" (
    id text NOT NULL,
    "ippId" text NOT NULL,
    contractor text NOT NULL,
    commitment text NOT NULL,
    "procurementStrategy" text NOT NULL,
    score double precision NOT NULL
);


--
-- Name: IPPEvaluation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPEvaluation" (
    id text NOT NULL,
    "ippId" text NOT NULL,
    "overallScore" double precision NOT NULL,
    "dataQuality" public."DataQuality" NOT NULL,
    confidence double precision NOT NULL,
    "reviewerName" text NOT NULL,
    "calculatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: IPPEvaluationParameter; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPEvaluationParameter" (
    id text NOT NULL,
    "evaluationId" text NOT NULL,
    key text NOT NULL,
    name text NOT NULL,
    "shortLabel" text NOT NULL,
    score double precision NOT NULL,
    weight double precision NOT NULL,
    "normalizedScore" double precision NOT NULL,
    "weightedContribution" double precision NOT NULL,
    evidence text NOT NULL,
    status public."GateStatus" NOT NULL,
    reviewer text NOT NULL,
    "dataQuality" public."DataQuality" NOT NULL
);


--
-- Name: IPPEvaluationScore; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPEvaluationScore" (
    id text NOT NULL,
    "evaluationId" text NOT NULL,
    key text NOT NULL,
    "baseScore" double precision NOT NULL,
    "appliedScore" double precision NOT NULL,
    reason text NOT NULL
);


--
-- Name: IPPExecutionSchedule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPExecutionSchedule" (
    id text NOT NULL,
    "ippId" text NOT NULL,
    milestones jsonb NOT NULL,
    "criticalPath" jsonb NOT NULL,
    "longestLeadItem" text NOT NULL,
    "regulatoryDependency" text NOT NULL,
    "procurementDependency" text NOT NULL,
    "financingDependency" text NOT NULL,
    "projectBufferMonths" double precision NOT NULL,
    "internalCod" timestamp(3) without time zone NOT NULL,
    "contractualCod" timestamp(3) without time zone NOT NULL,
    "downsideCod" timestamp(3) without time zone NOT NULL,
    "hasCpm" boolean NOT NULL,
    "procurementAligned" boolean NOT NULL,
    "connectivityAssumed" boolean NOT NULL,
    "epcCommitted" boolean NOT NULL
);


--
-- Name: IPPExperience; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPExperience" (
    id text NOT NULL,
    "ippId" text NOT NULL,
    "commissionedMw" double precision NOT NULL,
    "yearsOperating" integer NOT NULL,
    "projectsCompleted" integer NOT NULL,
    "notableProjects" text NOT NULL
);


--
-- Name: IPPFinancialModel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPFinancialModel" (
    id text NOT NULL,
    "ippId" text NOT NULL,
    "debtInrCr" double precision NOT NULL,
    "equityInrCr" double precision NOT NULL,
    "debtEquityRatio" double precision NOT NULL,
    "interestRate" double precision NOT NULL,
    "loanTenureYears" integer NOT NULL,
    "moratoriumYears" double precision NOT NULL,
    dscr double precision NOT NULL,
    "equityRequirementInrCr" double precision NOT NULL,
    "projectIrr" double precision NOT NULL,
    "equityIrr" double precision NOT NULL,
    "financialClosureDate" timestamp(3) without time zone,
    "lenderExperience" text NOT NULL,
    "lenderIdentified" boolean NOT NULL,
    "fundraisingDependency" boolean NOT NULL,
    "refinancingAssumptions" text NOT NULL,
    "capabilityScore" double precision NOT NULL,
    "dataQuality" public."DataQuality" NOT NULL,
    "financingScheduleMismatch" boolean NOT NULL
);


--
-- Name: IPPGenerationProfile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPGenerationProfile" (
    id text NOT NULL,
    "ippId" text NOT NULL,
    "p50Gwh" double precision NOT NULL,
    "p75Gwh" double precision NOT NULL,
    "p90Gwh" double precision NOT NULL,
    "resourceDatabase" text NOT NULL,
    "siteMeasurements" text NOT NULL,
    "independentValidation" public."DocumentStatus" NOT NULL,
    monthly jsonb NOT NULL,
    intervals jsonb NOT NULL,
    evidences jsonb NOT NULL,
    "dataQuality" public."DataQuality" NOT NULL
);


--
-- Name: IPPProject; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPProject" (
    id text NOT NULL,
    "ippId" text NOT NULL,
    name text NOT NULL,
    state text NOT NULL,
    "capacityMw" double precision NOT NULL,
    "codYear" integer NOT NULL,
    status text NOT NULL
);


--
-- Name: IPPRegulatoryProfile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPRegulatoryProfile" (
    id text NOT NULL,
    "ippId" text NOT NULL,
    items jsonb NOT NULL,
    "protectionScore" double precision NOT NULL,
    "changeInLaw" text NOT NULL,
    curtailment text NOT NULL,
    indemnity text NOT NULL,
    "complianceBearer" text NOT NULL,
    "delayBearer" text NOT NULL,
    "dataQuality" public."DataQuality" NOT NULL
);


--
-- Name: IPPSolarProfile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPSolarProfile" (
    id text NOT NULL,
    "ippId" text NOT NULL,
    "acMw" double precision NOT NULL,
    "dcMw" double precision NOT NULL,
    "dcAcRatio" double precision NOT NULL,
    "moduleTechnology" text NOT NULL,
    "inverterPhilosophy" text NOT NULL,
    cuf double precision NOT NULL,
    degradation double precision NOT NULL,
    clipping double precision NOT NULL,
    "auxiliaryConsumption" double precision NOT NULL,
    availability double precision NOT NULL,
    evidences jsonb NOT NULL,
    "dataQuality" public."DataQuality" NOT NULL
);


--
-- Name: IPPSuitability; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPSuitability" (
    id text NOT NULL,
    "gesRequirementId" text NOT NULL,
    "ippId" text NOT NULL,
    "overallPct" double precision NOT NULL,
    "compatibilityStatus" public."CompatibilityStatus" NOT NULL,
    "illustrativeSeedStatus" public."CompatibilityStatus",
    dimensions jsonb NOT NULL,
    "dataQuality" public."DataQuality" NOT NULL,
    "blockedByGate" boolean NOT NULL,
    "calculatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: IPPTariffComponent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPTariffComponent" (
    id text NOT NULL,
    "modelId" text NOT NULL,
    key text NOT NULL,
    label text NOT NULL,
    amount double precision NOT NULL,
    "capexLinked" boolean DEFAULT false NOT NULL,
    "debtLinked" boolean DEFAULT false NOT NULL,
    "bessLinked" boolean DEFAULT false NOT NULL,
    "fixedRecovery" boolean DEFAULT false NOT NULL,
    "sortOrder" integer NOT NULL
);


--
-- Name: IPPTariffModel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPTariffModel" (
    id text NOT NULL,
    "ippId" text NOT NULL,
    unit text DEFAULT 'INR/kWh'::text NOT NULL,
    "quotedTariff" double precision NOT NULL,
    "calculatedTariff" double precision NOT NULL,
    sustainability public."TariffSustainability" NOT NULL,
    "escalationClear" boolean NOT NULL,
    "evacuationExcluded" boolean NOT NULL,
    "bessExcluded" boolean NOT NULL,
    drivers jsonb NOT NULL
);


--
-- Name: IPPTariffScenario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPTariffScenario" (
    id text NOT NULL,
    "modelId" text NOT NULL,
    name text NOT NULL,
    assumptions jsonb NOT NULL,
    "baseTariff" double precision NOT NULL,
    "scenarioTariff" double precision NOT NULL,
    change double precision NOT NULL,
    "changePct" double precision NOT NULL,
    financial jsonb NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: IPPTechnology; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPTechnology" (
    id text NOT NULL,
    "ippId" text NOT NULL,
    solar boolean NOT NULL,
    wind boolean NOT NULL,
    bess boolean NOT NULL,
    hybrid boolean NOT NULL
);


--
-- Name: IPPWindProfile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."IPPWindProfile" (
    id text NOT NULL,
    "ippId" text NOT NULL,
    "wtgRatingMw" double precision NOT NULL,
    "hubHeightM" double precision NOT NULL,
    "rotorDiameterM" double precision NOT NULL,
    "resourceMethodology" text NOT NULL,
    cuf double precision NOT NULL,
    "wakeLoss" double precision NOT NULL,
    availability double precision NOT NULL,
    evidences jsonb NOT NULL,
    "dataQuality" public."DataQuality" NOT NULL
);


--
-- Name: LoadMatchResult; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."LoadMatchResult" (
    id text NOT NULL,
    "gesId" text NOT NULL,
    "ippId" text NOT NULL,
    "requiredGwh" double precision NOT NULL,
    "availableGwh" double precision NOT NULL,
    "matchedGwh" double precision NOT NULL,
    "surplusGwh" double precision NOT NULL,
    "deficitGwh" double precision NOT NULL,
    "coveragePct" double precision NOT NULL,
    "loadMatchPct" double precision NOT NULL,
    series jsonb NOT NULL,
    "dataQuality" public."DataQuality" NOT NULL,
    "calculatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: LoginOtp; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."LoginOtp" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "codeHash" text NOT NULL,
    "expiresAt" timestamp(3) without time zone NOT NULL,
    "resendAt" timestamp(3) without time zone NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    "consumedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: Negotiation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Negotiation" (
    id text NOT NULL,
    "gesId" text NOT NULL,
    "ippId" text NOT NULL,
    status text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "selectionId" text
);


--
-- Name: NegotiationOffer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."NegotiationOffer" (
    id text NOT NULL,
    "negotiationId" text NOT NULL,
    version integer NOT NULL,
    "offerType" public."OfferType" NOT NULL,
    tariff double precision NOT NULL,
    "codYear" integer NOT NULL,
    "bessSummary" text NOT NULL,
    "paymentTerms" text NOT NULL,
    "changeInLaw" text NOT NULL,
    curtailment text NOT NULL,
    "performanceGuarantee" text NOT NULL,
    "riskAllocation" text NOT NULL,
    "otherTerms" text NOT NULL,
    status public."OfferStatus" NOT NULL,
    "createdById" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: Permission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Permission" (
    id text NOT NULL,
    key public."PermissionKey" NOT NULL,
    description text NOT NULL
);


--
-- Name: Psoa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Psoa" (
    id text NOT NULL,
    "gesId" text NOT NULL,
    "ippId" text NOT NULL,
    items jsonb NOT NULL,
    status text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: QuestionnaireAnswer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."QuestionnaireAnswer" (
    id text NOT NULL,
    "gesId" text NOT NULL,
    "questionKey" text NOT NULL,
    value text DEFAULT ''::text NOT NULL,
    "updatedById" text DEFAULT ''::text NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "ippId" text,
    rating double precision
);


--
-- Name: RedFlag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."RedFlag" (
    id text NOT NULL,
    "ippId" text NOT NULL,
    "gesId" text,
    category public."RedFlagCategory" NOT NULL,
    severity public."RedFlagSeverity" NOT NULL,
    code text NOT NULL,
    title text NOT NULL,
    detail text NOT NULL,
    active boolean DEFAULT true NOT NULL
);


--
-- Name: RefreshToken; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."RefreshToken" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "tokenHash" text NOT NULL,
    "expiresAt" timestamp(3) without time zone NOT NULL,
    "revokedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: Role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Role" (
    id text NOT NULL,
    name public."RoleName" NOT NULL,
    description text NOT NULL
);


--
-- Name: RolePermission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."RolePermission" (
    "roleId" text NOT NULL,
    "permissionId" text NOT NULL
);


--
-- Name: SuitabilityConfig; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."SuitabilityConfig" (
    id text NOT NULL,
    name text NOT NULL,
    active boolean DEFAULT true NOT NULL,
    weights jsonb NOT NULL,
    "tariffFloor" double precision NOT NULL,
    "tariffCeiling" double precision NOT NULL,
    illustrative boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: TariffNegotiation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."TariffNegotiation" (
    id text NOT NULL,
    "gesId" text NOT NULL,
    "ippId" text NOT NULL,
    rounds jsonb NOT NULL,
    "updatedById" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Task; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Task" (
    id text NOT NULL,
    "gesId" text,
    "ippId" text,
    title text NOT NULL,
    "dueDate" timestamp(3) without time zone NOT NULL,
    "ownerId" text,
    "pendingFrom" text NOT NULL,
    priority public."TaskPriority" NOT NULL,
    status public."TaskStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: User; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."User" (
    id text NOT NULL,
    email text NOT NULL,
    name text NOT NULL,
    "passwordHash" text NOT NULL,
    title text NOT NULL,
    active boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "gesId" text,
    "accessStatus" public."GesAccessStatus" DEFAULT 'APPROVED'::public."GesAccessStatus" NOT NULL,
    phone text DEFAULT ''::text NOT NULL
);


--
-- Name: UserRole; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UserRole" (
    "userId" text NOT NULL,
    "roleId" text NOT NULL
);


--
-- Data for Name: Activity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Activity" (id, "gesId", "ippId", message, "actorId", "createdAt") FROM stdin;
\.


--
-- Data for Name: AuditLog; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AuditLog" (id, entity, "entityId", action, "oldValue", "newValue", "userId", "requestId", "createdAt") FROM stdin;
cmuub4ru9006xgudvpqrg787j	IPP	ipp_1791147762971	CREATE	\N	{"name": "SunGrid Renewable Energy"}	usr_newra_grids	\N	2026-10-04 21:02:43.953
cmur5h6u900dauzvvhaujxpq1	GES	ges_aster	SEED	\N	{"name": "Aster Manufacturing Group", "illustrative": true}	\N	\N	2026-10-02 16:01:07.041
cmuubm2yd00d3gudvu7f9mdhx	IPP	ipp_1791147762971	ASSUMPTIONS_UPDATED	\N	{"bessMw": 250, "p90Gwh": 3250, "tariff": 4, "bessMwh": 1000, "capexInrCr": 400, "interestRate": 0, "bessDurationHours": 4}	usr_newra_grids	\N	2026-10-04 21:16:11.509
cmuuviosm0009133frd5wr258	GES	ges_1791179386980	PROFILE_UPDATE	\N	{"fields": ["contactName", "contactEmail", "contactPhone", "notes", "name", "legalName", "businessType", "location", "state", "discom", "consumerNumbers", "annualConsumptionGwh", "contractDemandMw", "billedDemandMw", "existingRooftopMw", "existingRenewableGwh", "sanctionedLoadKw", "peakRecordedDemandKva"], "createdByRole": "NewRa Grids", "actingOnBehalfOfGes": true}	usr_newra_grids	\N	2026-10-05 06:33:25.511
cmuuw4re60003iyeyaje0ua5f	GESRequirement	req_ges_1791179386980	UPDATE	{"id": "req_ges_1791179386980", "gesId": "ges_1791179386980", "notes": "", "createdAt": "2026-10-05T05:49:46.993Z", "updatedAt": "2026-10-05T05:49:46.993Z", "dataQuality": "MISSING", "bessHoursMax": null, "bessHoursMin": null, "illustrative": true, "peakDemandMw": 0, "targetCodYear": 2027, "bessPreference": "OPTIONAL", "annualEnergyGwh": 0, "commercialNotes": "", "requiredCapacityGw": 0, "contractTenureYears": null, "requiredRenewableGwh": null, "preferredTechnologies": [], "targetTariffInrPerKwh": null, "renewableTargetPercent": null}	{"id": "req_ges_1791179386980", "gesId": "ges_1791179386980", "notes": "", "createdAt": "2026-10-05T05:49:46.993Z", "updatedAt": "2026-10-05T06:50:35.289Z", "dataQuality": "MISSING", "bessHoursMax": null, "bessHoursMin": 0, "illustrative": true, "peakDemandMw": 4.2, "targetCodYear": 2027, "bessPreference": "OPTIONAL", "annualEnergyGwh": 0, "commercialNotes": "", "requiredCapacityGw": 0, "contractTenureYears": null, "requiredRenewableGwh": 12.5, "preferredTechnologies": [], "targetTariffInrPerKwh": null, "renewableTargetPercent": null}	usr_newra_grids	\N	2026-10-05 06:50:35.31
cmuuw7al00026iyeygwrwt1ru	GESIPPSelection	ges_1791179386980:ipp_1791147762971	CONSIDER	\N	{"gesId": "ges_1791179386980", "ippId": "ipp_1791147762971", "ippName": "SunGrid Renewable Energy", "createdById": "usr_newra_grids", "createdByRole": "NewRa Grids", "actingOnBehalfOfGes": true}	usr_newra_grids	\N	2026-10-05 06:52:33.492
cmuuw8q4f002aiyey147s53b7	IPPTariffScenario	cmuuw8q450028iyeyz2soem4k	SCENARIO	\N	{"capexChangePct": 5, "codDelayMonths": 0, "cufReductionPct": 4, "bessCostChangePct": 0, "interestChangePctPoints": 1}	usr_newra_grids	\N	2026-10-05 06:53:40.288
cmuuw8zqm002eiyeycgdx2swd	IPPTariffScenario	cmuuw8zqg002ciyeyrux4xsww	SCENARIO	\N	{"capexChangePct": 5, "codDelayMonths": 5, "cufReductionPct": 4, "bessCostChangePct": 0, "interestChangePctPoints": 1}	usr_newra_grids	\N	2026-10-05 06:53:52.75
cmuuw930m002iiyey164cwq4e	IPPTariffScenario	cmuuw930f002giyeycu3tcubq	SCENARIO	\N	{"capexChangePct": 5, "codDelayMonths": 5, "cufReductionPct": 4, "bessCostChangePct": 0, "interestChangePctPoints": 1}	usr_newra_grids	\N	2026-10-05 06:53:56.998
cmuuw975n002miyeykj1b51vk	IPPTariffScenario	cmuuw975g002kiyeyc2bk4h31	SCENARIO	\N	{"capexChangePct": 5, "codDelayMonths": 5, "cufReductionPct": 4, "bessCostChangePct": 0, "interestChangePctPoints": 1}	usr_newra_grids	\N	2026-10-05 06:54:02.363
cmuuwcml0002qiyey1yiblqfu	CommercialRequirement	cmuuwcmki002oiyeyc1e20duk	CREATE	\N	{"gesId": "ges_1791179386980", "ippId": "ipp_1791147762971", "status": "SUBMITTED", "createdById": "usr_newra_grids", "selectionId": "cmuuw7abv0005iyeylpc397xp", "createdByRole": "NewRa Grids", "actingOnBehalfOfGes": true}	usr_newra_grids	\N	2026-10-05 06:56:42.324
cmuuwhfja002uiyey5ya7cp6g	NegotiationOffer	cmuuwhfiy002siyey5r1yp3q7	CREATE	\N	{"id": "cmuuwhfiy002siyey5r1yp3q7", "status": "OPEN", "tariff": 4.5, "codYear": 2030, "version": 1, "createdAt": "2026-10-05T07:00:26.458Z", "offerType": "COUNTER_OFFER", "otherTerms": "", "bessSummary": "4-hour storage capability subject to warranty review", "changeInLaw": "Symmetric change-in-law protection", "createdById": "usr_newra_grids", "curtailment": "Curtailment allocation subject to agreed thresholds", "paymentTerms": "Monthly settlement; payment security to be agreed", "negotiationId": "neg_ges_1791179386980_ipp_1791147762971", "riskAllocation": "Grid-side delay allocated to responsible party", "performanceGuarantee": "Generation and availability guarantees to be confirmed"}	usr_newra_grids	\N	2026-10-05 07:00:26.47
cmus6u0qz008uzogv333adcfa	GES	ges_1791019610501	CREATE	\N	{"name": "M/S Aurangabad Gymkhana Club"}	\N	\N	2026-10-03 09:26:51.468
cmus7a51m008yzogvqmeja2br	IPP	ipp_solstice	DELETE	{"name": "Solstice Hybrid"}	\N	\N	\N	2026-10-03 09:39:23.53
cmus7a91h0090zogvjxmmod7l	IPP	ipp_sungrid	DELETE	{"name": "SunGrid Renewable Energy"}	\N	\N	\N	2026-10-03 09:39:28.71
cmus7ac930092zogv6kys5t2g	IPP	ipp_terragrid	DELETE	{"name": "TerraGrid Renewables"}	\N	\N	\N	2026-10-03 09:39:32.871
cmus7afqu0094zogvrml9t0l1	IPP	ipp_windcore	DELETE	{"name": "WindCore Energy"}	\N	\N	\N	2026-10-03 09:39:37.398
cmus7b2j50096zogvehv299yp	GES	ges_nova	DELETE	{"name": "Nova Industrial Works"}	\N	\N	\N	2026-10-03 09:40:06.929
cmus7b6w60098zogv7li2ifbr	GES	ges_vertex	DELETE	{"name": "Vertex Metals & Engineering"}	\N	\N	\N	2026-10-03 09:40:12.582
cmusbqxwj0033mlzcw6x22par	IPP	ipp_1791027865185	CREATE	\N	{"name": "Flow Check Power"}	\N	\N	2026-10-03 11:44:25.892
cmv6qo1ab002dqalm56jgyt5s	GES	ges_1791899450611	CREATE	\N	{"name": "Rohit Hiwrale"}	usr_newra_grids	\N	2026-10-13 13:50:51.012
cmv6rs581000v146gumkvfzol	IPP	ipp_1791901322213	CREATE	\N	{"name": "SAEL Industries Limited"}	usr_newra_grids	\N	2026-10-13 14:22:02.354
cmv6rs5eb001p146gusc1ankk	IPP	ipp_1791901322469	CREATE	\N	{"name": "Hinduja Renewables Pvt. Ltd."}	usr_newra_grids	\N	2026-10-13 14:22:02.579
cmv6rs5ii002j146gzl10xn1z	IPP	ipp_1791901322663	CREATE	\N	{"name": "Lumara Energy (Brookfield backing stated in source)"}	usr_newra_grids	\N	2026-10-13 14:22:02.73
cmv6rs5n3003d146g4a3qztn9	IPP	ipp_1791901322836	CREATE	\N	{"name": "Fourth Partner Energy Limited"}	usr_newra_grids	\N	2026-10-13 14:22:02.895
cmv6rs5r80047146gbb1nbdop	IPP	ipp_1791901322977	CREATE	\N	{"name": "Alfanar Power"}	usr_newra_grids	\N	2026-10-13 14:22:03.044
cmv6rs5vh0051146gpn4wsxtk	IPP	ipp_1791901323132	CREATE	\N	{"name": "Sirius Renewables Power Pvt. Ltd."}	usr_newra_grids	\N	2026-10-13 14:22:03.197
cmv6rs5zs005v146gyrcxp9i4	IPP	ipp_1791901323285	CREATE	\N	{"name": "TrueRE / Oriana Power Limited"}	usr_newra_grids	\N	2026-10-13 14:22:03.352
cmv6rs63w006p146gubyx8cns	IPP	ipp_1791901323443	CREATE	\N	{"name": "Amplus (Gentari) Renewables Limited"}	usr_newra_grids	\N	2026-10-13 14:22:03.5
cmv6rs688007j146ghmqs5i27	IPP	ipp_1791901323592	CREATE	\N	{"name": "Apraava Energy"}	usr_newra_grids	\N	2026-10-13 14:22:03.657
cmv6rs6c4008d146g86zu172l	IPP	ipp_1791901323738	CREATE	\N	{"name": "Serentica Renewables"}	usr_newra_grids	\N	2026-10-13 14:22:03.796
cmv6rs6g10097146gxmfdh6oo	IPP	ipp_1791901323881	CREATE	\N	{"name": "Refex Renewables & Infrastructure Ltd."}	usr_newra_grids	\N	2026-10-13 14:22:03.938
cmv6rs6kf00a1146g5w9ey8p0	IPP	ipp_1791901324035	CREATE	\N	{"name": "GMR Renewable Energy Limited"}	usr_newra_grids	\N	2026-10-13 14:22:04.096
cmv6rs6oc00av146g71ie2mxm	IPP	ipp_1791901324175	CREATE	\N	{"name": "Goldi Solar Pvt. Ltd."}	usr_newra_grids	\N	2026-10-13 14:22:04.236
cmv6rs6sl00bp146glg1h1aas	IPP	ipp_1791901324322	CREATE	\N	{"name": "ReNew Energy"}	usr_newra_grids	\N	2026-10-13 14:22:04.39
cmv6rs6wt00cj146gmzsgqizg	IPP	ipp_1791901324487	CREATE	\N	{"name": "Razon Green"}	usr_newra_grids	\N	2026-10-13 14:22:04.541
cmv6rs71100dd146gdabr743y	IPP	ipp_1791901324632	CREATE	\N	{"name": "Sorigin Renewables"}	usr_newra_grids	\N	2026-10-13 14:22:04.693
cmv6rs75g00e7146gb4qezrvj	IPP	ipp_1791901324785	CREATE	\N	{"name": "Ozas Green (Ojas Green Energy Private Limited)"}	usr_newra_grids	\N	2026-10-13 14:22:04.852
cmv6rs79z00f1146gd6pyyh0i	IPP	ipp_1791901324956	CREATE	\N	{"name": "Zetwerk Renewable Energy"}	usr_newra_grids	\N	2026-10-13 14:22:05.015
cmv6rs7el00fv146gmk73qxls	IPP	ipp_1791901325112	CREATE	\N	{"name": "Solenco Infra"}	usr_newra_grids	\N	2026-10-13 14:22:05.182
cmv6suw2b0007v8pbcd7r30qb	GES	ges_1791899450611	DELETE	{"name": "Rohit Hiwrale"}	\N	usr_newra_grids	\N	2026-10-13 14:52:10.068
cmv6tmgyk05jjmk3o3fjxybp2	GES	ges_1791145602773	DELETE	{"name": "Aurangabad Industrial Components Pvt. Ltd."}	\N	usr_newra_grids	\N	2026-10-13 15:13:36.86
cmv6tmj5r05jlmk3osgznx4pb	GES	ges_1791019610501	DELETE	{"name": "M/S Aurangabad Gymkhana Club"}	\N	usr_newra_grids	\N	2026-10-13 15:13:39.712
cmv6tmliw05jnmk3ovdxjyfc7	GES	ges_1791193311726	DELETE	{"name": "NEW RAWAL ENTERPRISES"}	\N	usr_newra_grids	\N	2026-10-13 15:13:42.776
cmv6tmnex05jpmk3orcrk4y9w	GES	ges_1791146544755	DELETE	{"name": "Nova Automotive Systems"}	\N	usr_newra_grids	\N	2026-10-13 15:13:45.226
cmv6tmp7n05jrmk3ot6q0d0i0	GES	ges_1791179386980	DELETE	{"name": "Paavan Steel Tech Pvt Ltd"}	\N	usr_newra_grids	\N	2026-10-13 15:13:47.556
cmv6tmr0k05jtmk3oqo02c3yx	GES	ges_1791199127875	DELETE	{"name": "The World Energy"}	\N	usr_newra_grids	\N	2026-10-13 15:13:49.892
cmv6tokac06o0mk3ordd7okxz	GES	ges_1791904510208	CREATE	\N	{"name": "Rohit H"}	usr_newra_grids	\N	2026-10-13 15:15:14.485
cmur6391f00kacu8f2olvfb6t	GES	ges_1790957894313	CREATE	\N	{"name": "Orion Textiles"}	\N	\N	2026-10-02 16:18:16.323
cmur63ajm014jcu8fd23eyi92	GES	ges_1790957894313	UPDATE	{"name": "Orion Textiles"}	{"name": "Orion Textiles"}	\N	\N	2026-10-02 16:18:18.274
cmur63amh014lcu8f0adf5dmp	GES	ges_1790957894313	DELETE	{"name": "Orion Textiles"}	\N	\N	\N	2026-10-02 16:18:18.378
cmur65dwc01oycu8flw7duelw	GES	ges_1790957993785	CREATE	\N	{"name": "Orion Textiles"}	\N	\N	2026-10-02 16:19:55.932
cmur6ef8e01p2cu8fj2zmgju5	GES	ges_1790957993785	DELETE	{"name": "Orion Textiles"}	\N	\N	\N	2026-10-02 16:26:57.567
cmurz5btd008unjwwhqa8x1j6	IPP	ipp_1791006701064	CREATE	\N	{"name": "Cursor Check Power"}	\N	\N	2026-10-03 05:51:42.097
cmurz6111008tis75vrzgmk59	IPP	ipp_1791006733734	CREATE	\N	{"name": "Cursor Check Power"}	\N	\N	2026-10-03 05:52:14.774
cmurz8fup008uzjwbglxh431j	IPP	ipp_1791006846260	CREATE	\N	{"name": "Cursor Check Power"}	\N	\N	2026-10-03 05:54:07.297
cmurz8g7z008wzjwb8zltsflx	IPP	ipp_1791006846260	DELETE	{"name": "Cursor Check Power"}	\N	\N	\N	2026-10-03 05:54:07.775
cmurzk03y000fsbgnr7c09q5t	GES	ges_aster	DELETE	{"name": "Aster Manufacturing Group"}	\N	\N	\N	2026-10-03 06:03:06.766
cmurzk43g000hsbgn77ng2zzr	GES	ges_helix	DELETE	{"name": "Helix Chemicals"}	\N	\N	\N	2026-10-03 06:03:11.932
cmus0igpw000nsbgngpcpwufd	IPP	ipp_eastwind	DELETE	{"name": "EastWind Harvest"}	\N	\N	\N	2026-10-03 06:29:54.596
cmus0iiw9000psbgnap6i8l79	IPP	ipp_aerosun	DELETE	{"name": "AeroSun Energy"}	\N	\N	\N	2026-10-03 06:29:57.417
cmus0il06000rsbgnrp80g8bc	IPP	ipp_greenvolt	DELETE	{"name": "GreenVolt Power"}	\N	\N	\N	2026-10-03 06:30:00.15
cmus1brrp0001qyvsnfr9a38a	IPP	ipp_hybridgreen	DELETE	{"name": "HybridGreen Power"}	\N	\N	\N	2026-10-03 06:52:41.941
cmus1byrv0003qyvsrzdke25s	IPP	ipp_repower	DELETE	{"name": "RePower Infrastructure"}	\N	\N	\N	2026-10-03 06:52:51.019
cmus2q4x1000dzogvfmroy6ww	IPP	ipp_novarenewable	DELETE	{"name": "Nova Renewable Systems"}	\N	\N	\N	2026-10-03 07:31:51.781
cmusbqy6a0056mlzcxgh623jj	GESIPPSelection	ges_1791019610501:ipp_1791027865185	CONSIDER	\N	{"gesId": "ges_1791019610501", "ippId": "ipp_1791027865185", "ippName": "Flow Check Power", "createdById": "usr_admin", "createdByRole": "Super Admin", "actingOnBehalfOfGes": true}	\N	\N	2026-10-03 11:44:26.242
cmusbqy81005amlzc12urvvft	CommercialRequirement	cmusbqy7q0058mlzckf2ry0v5	CREATE	\N	{"gesId": "ges_1791019610501", "ippId": "ipp_1791027865185", "status": "SUBMITTED", "createdById": "usr_admin", "selectionId": "cmusbqxyr0035mlzchxe50the", "createdByRole": "Super Admin", "actingOnBehalfOfGes": true}	\N	\N	2026-10-03 11:44:26.305
cmusbqy9d005emlzcrbyzd1ss	CommercialRequirement	cmusbqy95005cmlzcyetotqil	CREATE	\N	{"gesId": "ges_1791019610501", "ippId": "ipp_1791027865185", "status": "UPDATED", "createdById": "usr_admin", "selectionId": "cmusbqxyr0035mlzchxe50the", "createdByRole": "Super Admin", "actingOnBehalfOfGes": true}	\N	\N	2026-10-03 11:44:26.354
cmusbqydl005gmlzcggvl8iqg	IPP	ipp_1791027865185	DELETE	{"name": "Flow Check Power"}	\N	\N	\N	2026-10-03 11:44:26.505
cmusc0qmx0001ycxrkis1f7we	GESRequirement	req_ges_1791019610501	UPDATE	{"id": "req_ges_1791019610501", "gesId": "ges_1791019610501", "notes": "", "createdAt": "2026-10-03T09:26:50.504Z", "updatedAt": "2026-10-03T09:26:50.504Z", "dataQuality": "PARTIAL", "bessHoursMax": 4, "bessHoursMin": 4, "illustrative": true, "peakDemandMw": 0.211, "targetCodYear": 2028, "bessPreference": "HOURS_4", "annualEnergyGwh": 0.2269, "commercialNotes": "", "requiredCapacityGw": 0, "contractTenureYears": null, "requiredRenewableGwh": null, "preferredTechnologies": ["SOLAR", "WIND", "BESS"], "targetTariffInrPerKwh": null, "renewableTargetPercent": null}	{"id": "req_ges_1791019610501", "gesId": "ges_1791019610501", "notes": "", "createdAt": "2026-10-03T09:26:50.504Z", "updatedAt": "2026-10-03T11:52:02.998Z", "dataQuality": "PARTIAL", "bessHoursMax": 4, "bessHoursMin": 4, "illustrative": true, "peakDemandMw": 0.211, "targetCodYear": 2028, "bessPreference": "HOURS_4", "annualEnergyGwh": 0.2269, "commercialNotes": "", "requiredCapacityGw": 0, "contractTenureYears": 3, "requiredRenewableGwh": 0.2269, "preferredTechnologies": ["SOLAR", "WIND", "BESS"], "targetTariffInrPerKwh": 4, "renewableTargetPercent": 50}	\N	\N	2026-10-03 11:52:03.033
cmusc6d890003ycxrnyx975kg	GESRequirement	req_ges_1791019610501	UPDATE	{"id": "req_ges_1791019610501", "gesId": "ges_1791019610501", "notes": "", "createdAt": "2026-10-03T09:26:50.504Z", "updatedAt": "2026-10-03T11:52:02.998Z", "dataQuality": "PARTIAL", "bessHoursMax": 4, "bessHoursMin": 4, "illustrative": true, "peakDemandMw": 0.211, "targetCodYear": 2028, "bessPreference": "HOURS_4", "annualEnergyGwh": 0.2269, "commercialNotes": "", "requiredCapacityGw": 0, "contractTenureYears": 3, "requiredRenewableGwh": 0.2269, "preferredTechnologies": ["SOLAR", "WIND", "BESS"], "targetTariffInrPerKwh": 4, "renewableTargetPercent": 50}	{"id": "req_ges_1791019610501", "gesId": "ges_1791019610501", "notes": "", "createdAt": "2026-10-03T09:26:50.504Z", "updatedAt": "2026-10-03T11:56:25.552Z", "dataQuality": "PARTIAL", "bessHoursMax": 4, "bessHoursMin": 4, "illustrative": true, "peakDemandMw": 0.211, "targetCodYear": 2028, "bessPreference": "HOURS_4", "annualEnergyGwh": 0.2269, "commercialNotes": "", "requiredCapacityGw": 0, "contractTenureYears": 3, "requiredRenewableGwh": 0.2269, "preferredTechnologies": ["SOLAR", "WIND", "BESS"], "targetTariffInrPerKwh": 4, "renewableTargetPercent": 50}	\N	\N	2026-10-03 11:56:25.593
cmuuqlsy8002cnvwpcfl9m4vy	GESRequirement	req_ges_1791146544755	UPDATE	{"id": "req_ges_1791146544755", "gesId": "ges_1791146544755", "notes": "", "createdAt": "2026-10-04T20:42:24.760Z", "updatedAt": "2026-10-04T20:42:24.760Z", "dataQuality": "MISSING", "bessHoursMax": null, "bessHoursMin": null, "illustrative": true, "peakDemandMw": 0, "targetCodYear": 2027, "bessPreference": "OPTIONAL", "annualEnergyGwh": 0, "commercialNotes": "", "requiredCapacityGw": 0, "contractTenureYears": null, "requiredRenewableGwh": null, "preferredTechnologies": [], "targetTariffInrPerKwh": null, "renewableTargetPercent": null}	{"id": "req_ges_1791146544755", "gesId": "ges_1791146544755", "notes": "", "createdAt": "2026-10-04T20:42:24.760Z", "updatedAt": "2026-10-05T04:15:52.468Z", "dataQuality": "MISSING", "bessHoursMax": 4, "bessHoursMin": 4, "illustrative": true, "peakDemandMw": 0, "targetCodYear": 2027, "bessPreference": "HOURS_4", "annualEnergyGwh": 0, "commercialNotes": "", "requiredCapacityGw": 0, "contractTenureYears": 3, "requiredRenewableGwh": null, "preferredTechnologies": ["SOLAR", "WIND", "BESS"], "targetTariffInrPerKwh": 3.9, "renewableTargetPercent": 50}	\N	\N	2026-10-05 04:15:52.784
cmuuwsetl0036iyeyaf1j8vp8	GES	ges_1791179386980	PROFILE_UPDATE	\N	{"fields": ["contactName", "contactEmail", "contactPhone", "notes"], "createdByRole": "GES Admin", "actingOnBehalfOfGes": false}	\N	\N	2026-10-05 07:08:58.762
cmuuwt2i60038iyeypdps8b6a	GES	ges_1791179386980	PROFILE_UPDATE	\N	{"fields": ["contactName", "contactEmail", "contactPhone", "notes"], "createdByRole": "GES Admin", "actingOnBehalfOfGes": false}	\N	\N	2026-10-05 07:09:29.454
cmuux3m100058iyeyqxndbeh3	GESRequirement	req_ges_1791179386980	UPDATE	{"id": "req_ges_1791179386980", "gesId": "ges_1791179386980", "notes": "", "createdAt": "2026-10-05T05:49:46.993Z", "updatedAt": "2026-10-05T06:51:57.107Z", "dataQuality": "MISSING", "bessHoursMax": null, "bessHoursMin": 0, "illustrative": true, "peakDemandMw": 0, "targetCodYear": 2027, "bessPreference": "OPTIONAL", "annualEnergyGwh": 0, "commercialNotes": "", "requiredCapacityGw": 0, "contractTenureYears": null, "requiredRenewableGwh": null, "preferredTechnologies": [], "targetTariffInrPerKwh": null, "renewableTargetPercent": null}	{"id": "req_ges_1791179386980", "gesId": "ges_1791179386980", "notes": "", "createdAt": "2026-10-05T05:49:46.993Z", "updatedAt": "2026-10-05T07:17:41.013Z", "dataQuality": "MISSING", "bessHoursMax": 4, "bessHoursMin": 4, "illustrative": true, "peakDemandMw": 0, "targetCodYear": 2028, "bessPreference": "HOURS_4", "annualEnergyGwh": 0, "commercialNotes": "", "requiredCapacityGw": 0, "contractTenureYears": null, "requiredRenewableGwh": null, "preferredTechnologies": [], "targetTariffInrPerKwh": null, "renewableTargetPercent": null}	\N	\N	2026-10-05 07:17:41.316
\.


--
-- Data for Name: CommercialRequirement; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."CommercialRequirement" (id, "selectionId", "gesId", "ippId", "targetTariffInrPerKwh", "requiredEnergyGwh", "requiredLoadMw", "contractTenureYears", "targetSupplyYear", notes, status, "createdById", "createdByRole", "actingOnBehalfOfGes", "createdAt") FROM stdin;
\.


--
-- Data for Name: Comparison; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Comparison" (id, "gesId", name, "createdById", working, "createdAt", "updatedAt") FROM stdin;
cmv6tnwxy05jwmk3oxkejd1kv	ges_1791904484133	Working comparison	usr_newra_grids	t	2026-10-13 15:14:44.23	2026-10-13 15:14:44.23
cmv6toh2305jzmk3o9prsg3qn	ges_1791904510208	Working comparison	usr_newra_grids	t	2026-10-13 15:15:10.3	2026-10-13 15:15:10.3
\.


--
-- Data for Name: ComparisonIPP; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."ComparisonIPP" ("comparisonId", "ippId", "position") FROM stdin;
cmv6tnwxy05jwmk3oxkejd1kv	ipp_1791901322977	0
cmv6tnwxy05jwmk3oxkejd1kv	ipp_1791901323443	1
cmv6tnwxy05jwmk3oxkejd1kv	ipp_1791901323592	2
cmv6toh2305jzmk3o9prsg3qn	ipp_1791901322977	0
cmv6toh2305jzmk3o9prsg3qn	ipp_1791901323443	1
cmv6toh2305jzmk3o9prsg3qn	ipp_1791901323592	2
\.


--
-- Data for Name: CriticalGate; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."CriticalGate" (id, key, name, description, "sortOrder") FROM stdin;
financial_capacity	financial_capacity	Financial Capacity	Balance sheet, equity and lender evidence can support the project.	1
execution_capability	execution_capability	Execution Capability	Track record and EPC commitment support delivery.	2
ehv_connectivity	ehv_connectivity	EHV Connectivity	Evacuation experience is evidenced. Project connectivity is not assumed.	3
credible_capex	credible_capex	Credible CAPEX	The cost build-up is supported by firm or quoted evidence.	4
sustainable_tariff	sustainable_tariff	Sustainable PPA Tariff	The quoted tariff can carry CAPEX, financing, operations and risk.	5
realistic_cod	realistic_cod	Realistic COD	The schedule has a critical path, buffer and aligned procurement.	6
generation_methodology	generation_methodology	Generation Methodology	P50 and P90 exist and the resource case is independently reviewed.	7
fdre_load_matching	fdre_load_matching	FDRE / Load Matching	The generation shape, with BESS where required, can follow the GES load.	8
regulatory_protection	regulatory_protection	Regulatory Protection	Change in law, curtailment and compliance risk are allocated.	9
newra_scada	newra_scada	NewRa SCADA / Scheduling Integration	Scheduling and SCADA integration with NewRa is evidenced.	10
\.


--
-- Data for Name: CriticalGateResult; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."CriticalGateResult" (id, "gateId", "ippId", "gesId", status, rationale, evidence) FROM stdin;
cmv6tohj605nomk3oot0wqb0r	financial_capacity	ipp_1791901323443	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6tohj605npmk3ov5kea7fq	execution_capability	ipp_1791901323443	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6tohj605nqmk3ou04fpt2j	ehv_connectivity	ipp_1791901323443	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6tohj605nrmk3o1ngizcqm	credible_capex	ipp_1791901323443	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6tohj605nsmk3ofrosrkvd	sustainable_tariff	ipp_1791901323443	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6tohj605ntmk3oxsyayyxa	realistic_cod	ipp_1791901323443	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6tohj605numk3oxrzkqzow	generation_methodology	ipp_1791901323443	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6tohj605nvmk3o9q577lgh	fdre_load_matching	ipp_1791901323443	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6tohj605nwmk3owddxi8u3	regulatory_protection	ipp_1791901323443	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6tohj605nxmk3oykapbqfr	newra_scada	ipp_1791901323443	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
cmv6tohum05romk3olu2ged5w	financial_capacity	ipp_1791901322836	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6tohum05rpmk3o6dwhyjut	execution_capability	ipp_1791901322836	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6tohum05rqmk3oqbyngygc	ehv_connectivity	ipp_1791901322836	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6tohum05rrmk3olgxj980h	credible_capex	ipp_1791901322836	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6tohum05rsmk3or9rga6ua	sustainable_tariff	ipp_1791901322836	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6tohum05rtmk3o5juk6pf9	realistic_cod	ipp_1791901322836	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6tohum05rumk3ox2a6tlz8	generation_methodology	ipp_1791901322836	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6tohum05rvmk3odm1h7tmk	fdre_load_matching	ipp_1791901322836	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6tohum05rwmk3o185x5k8y	regulatory_protection	ipp_1791901322836	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6tohum05rxmk3ofzyiwysu	newra_scada	ipp_1791901322836	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
cmv6toi4p05vomk3oupktgnsn	financial_capacity	ipp_1791901324175	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6toi4p05vpmk3ooenlgyq5	execution_capability	ipp_1791901324175	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6toi4p05vqmk3o7q2sfl38	ehv_connectivity	ipp_1791901324175	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6toi4p05vrmk3oo56mebyi	credible_capex	ipp_1791901324175	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6toi4p05vsmk3o1qrppvn1	sustainable_tariff	ipp_1791901324175	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6toi4p05vtmk3o8o0qcgz4	realistic_cod	ipp_1791901324175	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6toi4p05vumk3owy0qy9u0	generation_methodology	ipp_1791901324175	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6toi4q05vvmk3oyrifw8d2	fdre_load_matching	ipp_1791901324175	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6toi4q05vwmk3o1fj1yhgv	regulatory_protection	ipp_1791901324175	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6toi4q05vxmk3ol1xcmtez	newra_scada	ipp_1791901324175	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
cmv6toif905zomk3oo61zb04w	financial_capacity	ipp_1791901322663	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6toif905zpmk3oid7rfb03	execution_capability	ipp_1791901322663	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6toif905zqmk3osar7ngyl	ehv_connectivity	ipp_1791901322663	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6toif905zrmk3owpq9uv1j	credible_capex	ipp_1791901322663	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6toif905zsmk3oimn17l6r	sustainable_tariff	ipp_1791901322663	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6toif905ztmk3o64o7dzz9	realistic_cod	ipp_1791901322663	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6toif905zumk3ok47zbyiv	generation_methodology	ipp_1791901322663	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6toif905zvmk3o041koxsa	fdre_load_matching	ipp_1791901322663	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6toif905zwmk3o9tlbzkdj	regulatory_protection	ipp_1791901322663	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6toif905zxmk3ojsdqhcyi	newra_scada	ipp_1791901322663	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
cmv6tohd205lomk3oj8ehn2x7	financial_capacity	ipp_1791901322977	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6tohd205lpmk3opvac7cou	execution_capability	ipp_1791901322977	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6tohd205lqmk3o8rjsuib7	ehv_connectivity	ipp_1791901322977	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6tohd205lrmk3o4vzibw9o	credible_capex	ipp_1791901322977	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6tohd205lsmk3obd6vet8e	sustainable_tariff	ipp_1791901322977	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6tohd205ltmk3o2ny9c7ee	realistic_cod	ipp_1791901322977	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6tohd205lumk3otfbf3458	generation_methodology	ipp_1791901322977	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6tohd205lvmk3o46qs7ksg	fdre_load_matching	ipp_1791901322977	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6tohd205lwmk3oyeheynx1	regulatory_protection	ipp_1791901322977	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6tohd205lxmk3oklib3xuk	newra_scada	ipp_1791901322977	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
cmv6tohox05pomk3ozs0rxowq	financial_capacity	ipp_1791901323592	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6tohox05ppmk3okeikqenp	execution_capability	ipp_1791901323592	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6tohox05pqmk3oyyyxy2qy	ehv_connectivity	ipp_1791901323592	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6tohox05prmk3onmx9sskj	credible_capex	ipp_1791901323592	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6tohox05psmk3oua3vvwux	sustainable_tariff	ipp_1791901323592	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6tohox05ptmk3odj4yzed4	realistic_cod	ipp_1791901323592	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6tohox05pumk3ourvd4uy6	generation_methodology	ipp_1791901323592	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6tohox05pvmk3ogver75dq	fdre_load_matching	ipp_1791901323592	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6tohox05pwmk3olszolelr	regulatory_protection	ipp_1791901323592	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6tohox05pxmk3oi22pyad8	newra_scada	ipp_1791901323592	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
cmv6tohzq05tomk3osvmondxe	financial_capacity	ipp_1791901324035	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6tohzq05tpmk3of20m6xas	execution_capability	ipp_1791901324035	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6tohzq05tqmk3o0pk5o7vg	ehv_connectivity	ipp_1791901324035	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6tohzq05trmk3o63fjweh2	credible_capex	ipp_1791901324035	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6tohzq05tsmk3oj1plicnb	sustainable_tariff	ipp_1791901324035	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6tohzq05ttmk3ol3lrz3l2	realistic_cod	ipp_1791901324035	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6tohzq05tumk3okua5zyyg	generation_methodology	ipp_1791901324035	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6tohzq05tvmk3orftemy00	fdre_load_matching	ipp_1791901324035	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6tohzq05twmk3ofyqyxzv9	regulatory_protection	ipp_1791901324035	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6tohzq05txmk3o9rhoveqn	newra_scada	ipp_1791901324035	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
cmv6toia305xomk3oldqy1e5a	financial_capacity	ipp_1791901322469	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6toia305xpmk3o6b738kv9	execution_capability	ipp_1791901322469	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6toia305xqmk3ox8x4s4cf	ehv_connectivity	ipp_1791901322469	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6toia305xrmk3olsr6r6nw	credible_capex	ipp_1791901322469	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6toia305xsmk3olntfhkkq	sustainable_tariff	ipp_1791901322469	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6toia305xtmk3oyslfa4bf	realistic_cod	ipp_1791901322469	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6toia305xumk3oa8lhawmn	generation_methodology	ipp_1791901322469	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6toia305xvmk3ouj5ibook	fdre_load_matching	ipp_1791901322469	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6toia305xwmk3o5bueu4s3	regulatory_protection	ipp_1791901322469	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6toia305xxmk3o9xexpovn	newra_scada	ipp_1791901322469	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
cmv6toild061omk3o0jh3vq2w	financial_capacity	ipp_1791901324785	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6toild061pmk3o55mh3m6m	execution_capability	ipp_1791901324785	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6toild061qmk3o0uwmilsp	ehv_connectivity	ipp_1791901324785	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6toild061rmk3o2gzala6j	credible_capex	ipp_1791901324785	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6toild061smk3o7npbzccf	sustainable_tariff	ipp_1791901324785	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6toild061tmk3o9sbbtcbt	realistic_cod	ipp_1791901324785	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6toild061umk3ok6w84216	generation_methodology	ipp_1791901324785	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6toild061vmk3owxp3j84b	fdre_load_matching	ipp_1791901324785	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6toild061wmk3oxto2vjix	regulatory_protection	ipp_1791901324785	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6toild061xmk3odicgi2l0	newra_scada	ipp_1791901324785	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
cmv6toj1e065omk3ov2i2kxju	financial_capacity	ipp_1791901324322	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6toj1e065pmk3oxhbhyi6b	execution_capability	ipp_1791901324322	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6toj1e065qmk3o4cpqe95b	ehv_connectivity	ipp_1791901324322	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6toj1e065rmk3o93kf6pxb	credible_capex	ipp_1791901324322	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6toj1e065smk3oefkl9k4w	sustainable_tariff	ipp_1791901324322	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6toj1e065tmk3ois1esclw	realistic_cod	ipp_1791901324322	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6toj1e065umk3ogp9tjl5r	generation_methodology	ipp_1791901324322	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6toj1e065vmk3osi0g99y5	fdre_load_matching	ipp_1791901324322	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6toj1e065wmk3ojurwmd4w	regulatory_protection	ipp_1791901324322	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6toj1e065xmk3okzywapi7	newra_scada	ipp_1791901324322	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
cmv6tojbp069omk3orqz42div	financial_capacity	ipp_1791901322213	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6tojbp069pmk3o09qxjziz	execution_capability	ipp_1791901322213	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6tojbp069qmk3onlbv5wej	ehv_connectivity	ipp_1791901322213	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6tojbp069rmk3o10182vqt	credible_capex	ipp_1791901322213	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6tojbp069smk3omrj6pi1r	sustainable_tariff	ipp_1791901322213	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6tojbp069tmk3oiqbc0btr	realistic_cod	ipp_1791901322213	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6tojbp069umk3os6amsykr	generation_methodology	ipp_1791901322213	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6tojbp069vmk3of7xsvag4	fdre_load_matching	ipp_1791901322213	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6tojbp069wmk3ob02pea14	regulatory_protection	ipp_1791901322213	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6tojbp069xmk3o7qs6w14h	newra_scada	ipp_1791901322213	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
cmv6tojln06domk3o6qq66paj	financial_capacity	ipp_1791901323132	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6tojln06dpmk3oisyvobja	execution_capability	ipp_1791901323132	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6tojln06dqmk3ojfgbrjtt	ehv_connectivity	ipp_1791901323132	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6tojln06drmk3o3rjr29pc	credible_capex	ipp_1791901323132	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6tojln06dsmk3opcek6o38	sustainable_tariff	ipp_1791901323132	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6tojln06dtmk3o39ebmzkc	realistic_cod	ipp_1791901323132	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6tojln06dumk3ol5njmels	generation_methodology	ipp_1791901323132	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6tojln06dvmk3o0t5lzxk4	fdre_load_matching	ipp_1791901323132	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6tojlo06dwmk3oin2huxdq	regulatory_protection	ipp_1791901323132	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6tojlo06dxmk3o3ar9ni97	newra_scada	ipp_1791901323132	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
cmv6tojvr06homk3oisyrdrrb	financial_capacity	ipp_1791901324632	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6tojvr06hpmk3o4kwmvm6t	execution_capability	ipp_1791901324632	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6toiwc063omk3olqulwd70	financial_capacity	ipp_1791901324487	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6toiwc063pmk3oc7qegjqq	execution_capability	ipp_1791901324487	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6toiwc063qmk3oof3j5k2h	ehv_connectivity	ipp_1791901324487	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6toiwc063rmk3otrgmwvc3	credible_capex	ipp_1791901324487	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6toiwc063smk3o6leh1ic9	sustainable_tariff	ipp_1791901324487	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6toiwc063tmk3oas8gfohi	realistic_cod	ipp_1791901324487	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6toiwc063umk3o97g1ykv4	generation_methodology	ipp_1791901324487	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6toiwc063vmk3o4yim5tpe	fdre_load_matching	ipp_1791901324487	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6toiwc063wmk3ol6z98bmi	regulatory_protection	ipp_1791901324487	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6toiwc063xmk3ow1phea0e	newra_scada	ipp_1791901324487	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
cmv6toj6o067omk3o5gmxemaf	financial_capacity	ipp_1791901323881	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6toj6o067pmk3o8a6cdl45	execution_capability	ipp_1791901323881	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6toj6o067qmk3o74tf3mxw	ehv_connectivity	ipp_1791901323881	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6toj6o067rmk3o40i6nk2c	credible_capex	ipp_1791901323881	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6toj6o067smk3ooj0y1qlt	sustainable_tariff	ipp_1791901323881	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6toj6o067tmk3o3xu1c3vc	realistic_cod	ipp_1791901323881	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6toj6o067umk3o95cf3l4c	generation_methodology	ipp_1791901323881	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6toj6o067vmk3oqr1z35uj	fdre_load_matching	ipp_1791901323881	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6toj6o067wmk3ov95t07q3	regulatory_protection	ipp_1791901323881	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6toj6o067xmk3ozbftnk66	newra_scada	ipp_1791901323881	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
cmv6tojgc06bomk3oujkhio1t	financial_capacity	ipp_1791901323738	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6tojgc06bpmk3onvaa7jvp	execution_capability	ipp_1791901323738	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6tojgc06bqmk3orxz3na80	ehv_connectivity	ipp_1791901323738	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6tojgc06brmk3oy0hfndsl	credible_capex	ipp_1791901323738	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6tojgc06bsmk3ov1c2kcoe	sustainable_tariff	ipp_1791901323738	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6tojgc06btmk3ozelc6zzu	realistic_cod	ipp_1791901323738	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6tojgc06bumk3o0khu7fs6	generation_methodology	ipp_1791901323738	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6tojgc06bvmk3ow8whce79	fdre_load_matching	ipp_1791901323738	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6tojgc06bwmk3ommidvroz	regulatory_protection	ipp_1791901323738	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6tojgc06bxmk3oxop9dqrv	newra_scada	ipp_1791901323738	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
cmv6tojqo06fomk3ojr9l4rmo	financial_capacity	ipp_1791901325112	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6tojqo06fpmk3onaatovb6	execution_capability	ipp_1791901325112	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6tojqo06fqmk3ojo3d0izd	ehv_connectivity	ipp_1791901325112	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6tojqo06frmk3ooizkpx6u	credible_capex	ipp_1791901325112	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6tojqo06fsmk3o1145y50c	sustainable_tariff	ipp_1791901325112	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6tojqo06ftmk3onu4g6c8m	realistic_cod	ipp_1791901325112	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6tojqo06fumk3olct7gdsf	generation_methodology	ipp_1791901325112	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6tojqo06fvmk3ofogkcjs6	fdre_load_matching	ipp_1791901325112	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6tojqo06fwmk3ocxnwffs8	regulatory_protection	ipp_1791901325112	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6tojqo06fxmk3oidyjs1ys	newra_scada	ipp_1791901325112	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
cmv6tojvr06hqmk3o00hj892g	ehv_connectivity	ipp_1791901324632	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6tojvr06hrmk3ok1gtqbv9	credible_capex	ipp_1791901324632	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6tojvr06hsmk3o3vq0qm8g	sustainable_tariff	ipp_1791901324632	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6tojvr06htmk3o81a28u6q	realistic_cod	ipp_1791901324632	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6tojvr06humk3o22qbmag1	generation_methodology	ipp_1791901324632	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6tojvr06hvmk3o3qsi2pgb	fdre_load_matching	ipp_1791901324632	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6tojvr06hwmk3o59008rfx	regulatory_protection	ipp_1791901324632	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6tojvr06hxmk3o5ece32dv	newra_scada	ipp_1791901324632	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
cmv6tok5906lnmk3obacy7y6u	financial_capacity	ipp_1791901323285	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6tok5906lomk3oytki7wjs	execution_capability	ipp_1791901323285	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6tok5906lpmk3on7kklddh	ehv_connectivity	ipp_1791901323285	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6tok5906lqmk3ow5r95a58	credible_capex	ipp_1791901323285	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6tok5906lrmk3o9t0tnckk	sustainable_tariff	ipp_1791901323285	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6tok5906lsmk3olum94arn	realistic_cod	ipp_1791901323285	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6tok5906ltmk3opi1jdevn	generation_methodology	ipp_1791901323285	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6tok5906lumk3omziu9ysj	fdre_load_matching	ipp_1791901323285	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6tok5906lvmk3obemuft0r	regulatory_protection	ipp_1791901323285	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6tok5906lwmk3oa81400kb	newra_scada	ipp_1791901323285	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
cmv6toka006nnmk3omquo2ah8	financial_capacity	ipp_1791901324956	ges_1791904510208	FAIL	Financial capacity does not support the quoted structure.	DSCR 0.00 · lender identified
cmv6toka006nomk3of1w2wz3e	execution_capability	ipp_1791901324956	ges_1791904510208	CONDITIONAL	Execution needs a firmer EPC commitment or a stronger delivery record.	Execution score 4.0 / 5
cmv6toka006npmk3oeabaxhb0	ehv_connectivity	ipp_1791901324956	ges_1791904510208	CONDITIONAL	Evacuation capability is evidenced, but this project's connectivity is not confirmed.	UNDER STUDY
cmv6toka006nqmk3o92ekmgva	credible_capex	ipp_1791901324956	ges_1791904510208	FAIL	CAPEX evidence is not credible enough to clear the gate.	Credibility 3.72 / 5
cmv6toka006nrmk3onxxfrgac	sustainable_tariff	ipp_1791901324956	ges_1791904510208	FAIL	The quoted tariff does not sustain the cost, financing and risk stack.	UNSUSTAINABLE
cmv6toka006nsmk3ollr7cfb2	realistic_cod	ipp_1791901324956	ges_1791904510208	PASS	COD is supported by a schedule, buffer and aligned procurement.	Critical path present
cmv6toka006ntmk3okqi2vqni	generation_methodology	ipp_1791901324956	ges_1791904510208	FAIL	P50 or P90 is missing.	PENDING
cmv6toka006numk3ot3oiw822	fdre_load_matching	ipp_1791901324956	ges_1791904510208	FAIL	The profile cannot follow this GES load without a failed energy gap.	Load match 0.0%
cmv6toka006nvmk3o6wosiuxv	regulatory_protection	ipp_1791901324956	ges_1791904510208	CONDITIONAL	One or more regulatory protections remain ambiguous.	Change in law shared
cmv6toka006nwmk3oci6x278i	newra_scada	ipp_1791901324956	ges_1791904510208	CONDITIONAL	NewRa SCADA integration is planned or not yet evidenced.	PLANNED
\.


--
-- Data for Name: Dealbook; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Dealbook" (id, "gesId", "ippId", recommendation, conditions, summary, approvals, illustrative, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Document; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Document" (id, "gesId", "ippId", category, title, status, "ownerId", "pendingFrom", location, comments, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: DocumentVersion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."DocumentVersion" (id, "documentId", version, "sentDate", "receivedDate", "signedDate", notes) FROM stdin;
\.


--
-- Data for Name: GES; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."GES" (id, name, "legalName", "businessType", location, state, discom, "consumerNumbers", "contractDemandMw", "billedDemandMw", "existingRooftopMw", "existingRenewableGwh", "annualConsumptionGwh", notes, illustrative, "crmStage", "evaluationStage", "createdAt", "updatedAt", "renewableEnergyTargetPercent", "sanctionedLoadKw", "solarConnectionType", "peakRecordedDemandKva", "bessRequirement", "contactEmail", "contactName", "contactPhone", "fieldProvenance", "plantAddress", "zoneConsumption") FROM stdin;
ges_1791904484133	Rohit Hiwrale	Rohit Hiwrale	Industrial					0	0	0	0	0		t	CLIENT_DISCOVERY	IPP_EVALUATION	2026-10-13 15:14:44.136	2026-10-13 15:14:44.136	\N	\N	\N	\N	\N				\N		{"zones": [], "period": "annual"}
ges_1791904510208	Rohit H	Rohit H	Industrial					0	0	0	0	0		t	CLIENT_DISCOVERY	IPP_EVALUATION	2026-10-13 15:15:10.211	2026-10-13 15:15:10.211	\N	\N	\N	\N	\N				\N		{"zones": [], "period": "annual"}
\.


--
-- Data for Name: GESConsumer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."GESConsumer" (id, "gesId", "consumerNumber", discom, "contractDemandMw", "billedDemandMw", "voltageLevel") FROM stdin;
cmv6tnwvb05jumk3o9peroufq	ges_1791904484133			0	0	33 kV
cmv6togzm05jxmk3os6weamck	ges_1791904510208			0	0	33 kV
\.


--
-- Data for Name: GESIPPSelection; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."GESIPPSelection" (id, "gesId", "ippId", "gesRequirementId", status, "createdById", "createdByRole", "actingOnBehalfOfGes", "updatedById", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: GESLoadProfile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."GESLoadProfile" (id, "gesId", name, "intervalMinutes", intervals, "annualEnergyGwh", "peakMw", "dataQuality", source, "evidenceStatus", illustrative) FROM stdin;
load_ges_1791904484133	ges_1791904484133	Illustrative 15-minute operating day	15	[]	0	0	PARTIAL	Daytime industrial shape scaled to the annual requirement	PENDING	t
load_ges_1791904510208	ges_1791904510208	Illustrative 15-minute operating day	15	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	0	0	PARTIAL	Daytime industrial shape scaled to the annual requirement	PENDING	t
\.


--
-- Data for Name: GESRequirement; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."GESRequirement" (id, "gesId", "annualEnergyGwh", "peakDemandMw", "requiredCapacityGw", "targetCodYear", "preferredTechnologies", "bessPreference", "bessHoursMin", "bessHoursMax", notes, "dataQuality", illustrative, "createdAt", "updatedAt", "commercialNotes", "contractTenureYears", "renewableTargetPercent", "requiredRenewableGwh", "targetTariffInrPerKwh") FROM stdin;
req_ges_1791904484133	ges_1791904484133	0	0	0	0	{}	OPTIONAL	0	\N		PARTIAL	t	2026-10-13 15:14:44.136	2026-10-13 15:14:44.136		\N	\N	\N	\N
req_ges_1791904510208	ges_1791904510208	0	0	0	0	{}	OPTIONAL	0	\N		PARTIAL	t	2026-10-13 15:15:10.211	2026-10-13 15:15:10.211		\N	\N	\N	\N
\.


--
-- Data for Name: GESRequirementIPP; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."GESRequirementIPP" (id, "gesRequirementId", "ippId", "compatibilityStatus", "illustrativeSeedStatus", "suitabilityScore", "technicalFit", "commercialFit", "financialFit", "generationFit", "loadMatchScore", shortlisted, "createdAt", "updatedAt") FROM stdin;
link_ges_1791904484133_ipp_1791901322977	req_ges_1791904484133	ipp_1791901322977	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.157	2026-10-13 15:14:44.157
link_ges_1791904484133_ipp_1791901323443	req_ges_1791904484133	ipp_1791901323443	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.163	2026-10-13 15:14:44.163
link_ges_1791904484133_ipp_1791901323592	req_ges_1791904484133	ipp_1791901323592	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.167	2026-10-13 15:14:44.167
link_ges_1791904484133_ipp_1791901322836	req_ges_1791904484133	ipp_1791901322836	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.17	2026-10-13 15:14:44.17
link_ges_1791904484133_ipp_1791901324035	req_ges_1791904484133	ipp_1791901324035	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.173	2026-10-13 15:14:44.173
link_ges_1791904484133_ipp_1791901324175	req_ges_1791904484133	ipp_1791901324175	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.177	2026-10-13 15:14:44.177
link_ges_1791904484133_ipp_1791901322469	req_ges_1791904484133	ipp_1791901322469	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.181	2026-10-13 15:14:44.181
link_ges_1791904484133_ipp_1791901322663	req_ges_1791904484133	ipp_1791901322663	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.185	2026-10-13 15:14:44.185
link_ges_1791904484133_ipp_1791901324785	req_ges_1791904484133	ipp_1791901324785	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.188	2026-10-13 15:14:44.188
link_ges_1791904484133_ipp_1791901324487	req_ges_1791904484133	ipp_1791901324487	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.191	2026-10-13 15:14:44.191
link_ges_1791904484133_ipp_1791901324322	req_ges_1791904484133	ipp_1791901324322	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.194	2026-10-13 15:14:44.194
link_ges_1791904484133_ipp_1791901323881	req_ges_1791904484133	ipp_1791901323881	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.198	2026-10-13 15:14:44.198
link_ges_1791904484133_ipp_1791901322213	req_ges_1791904484133	ipp_1791901322213	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.202	2026-10-13 15:14:44.202
link_ges_1791904484133_ipp_1791901323738	req_ges_1791904484133	ipp_1791901323738	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.205	2026-10-13 15:14:44.205
link_ges_1791904484133_ipp_1791901323132	req_ges_1791904484133	ipp_1791901323132	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.208	2026-10-13 15:14:44.208
link_ges_1791904484133_ipp_1791901325112	req_ges_1791904484133	ipp_1791901325112	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.212	2026-10-13 15:14:44.212
link_ges_1791904484133_ipp_1791901324632	req_ges_1791904484133	ipp_1791901324632	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.216	2026-10-13 15:14:44.216
link_ges_1791904484133_ipp_1791901323285	req_ges_1791904484133	ipp_1791901323285	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.223	2026-10-13 15:14:44.223
link_ges_1791904484133_ipp_1791901324956	req_ges_1791904484133	ipp_1791901324956	CONDITIONAL	CONDITIONAL	0	0	0	0	0	0	f	2026-10-13 15:14:44.226	2026-10-13 15:14:44.226
link_ges_1791904510208_ipp_1791901322977	req_ges_1791904510208	ipp_1791901322977	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.222	2026-10-13 15:15:10.684
link_ges_1791904510208_ipp_1791901323443	req_ges_1791904510208	ipp_1791901323443	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.225	2026-10-13 15:15:10.904
link_ges_1791904510208_ipp_1791901323592	req_ges_1791904510208	ipp_1791901323592	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.228	2026-10-13 15:15:11.109
link_ges_1791904510208_ipp_1791901322836	req_ges_1791904510208	ipp_1791901322836	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.231	2026-10-13 15:15:11.314
link_ges_1791904510208_ipp_1791901324035	req_ges_1791904510208	ipp_1791901324035	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.235	2026-10-13 15:15:11.504
link_ges_1791904510208_ipp_1791901324175	req_ges_1791904510208	ipp_1791901324175	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.238	2026-10-13 15:15:11.678
link_ges_1791904510208_ipp_1791901322469	req_ges_1791904510208	ipp_1791901322469	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.242	2026-10-13 15:15:11.868
link_ges_1791904510208_ipp_1791901322663	req_ges_1791904510208	ipp_1791901322663	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.245	2026-10-13 15:15:12.063
link_ges_1791904510208_ipp_1791901324785	req_ges_1791904510208	ipp_1791901324785	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.247	2026-10-13 15:15:12.269
link_ges_1791904510208_ipp_1791901324487	req_ges_1791904510208	ipp_1791901324487	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.25	2026-10-13 15:15:12.665
link_ges_1791904510208_ipp_1791901324322	req_ges_1791904510208	ipp_1791901324322	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.255	2026-10-13 15:15:12.857
link_ges_1791904510208_ipp_1791901323881	req_ges_1791904510208	ipp_1791901323881	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.258	2026-10-13 15:15:13.047
link_ges_1791904510208_ipp_1791901322213	req_ges_1791904510208	ipp_1791901322213	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.261	2026-10-13 15:15:13.23
link_ges_1791904510208_ipp_1791901323738	req_ges_1791904510208	ipp_1791901323738	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.264	2026-10-13 15:15:13.396
link_ges_1791904510208_ipp_1791901323132	req_ges_1791904510208	ipp_1791901323132	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.271	2026-10-13 15:15:13.586
link_ges_1791904510208_ipp_1791901325112	req_ges_1791904510208	ipp_1791901325112	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.277	2026-10-13 15:15:13.767
link_ges_1791904510208_ipp_1791901324632	req_ges_1791904510208	ipp_1791901324632	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.281	2026-10-13 15:15:13.95
link_ges_1791904510208_ipp_1791901323285	req_ges_1791904510208	ipp_1791901323285	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.293	2026-10-13 15:15:14.297
link_ges_1791904510208_ipp_1791901324956	req_ges_1791904510208	ipp_1791901324956	GATE_FAILED	CONDITIONAL	49.73	90	58	57.6	0	0	f	2026-10-13 15:15:10.296	2026-10-13 15:15:14.465
\.


--
-- Data for Name: IPP; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPP" (id, name, "legalName", headquarters, "technologySummary", "solarMw", "windMw", "bessMw", "bessMwh", "annualGenerationGwh", "p90Gwh", "indicativeTariffInrPerKwh", "targetCodYear", "evaluationStage", "pendingFrom", illustrative, baseline, "createdAt", "updatedAt", "projectDistrict", "projectLocation", "generationData15Min", "fdreCapability", "gridVoltage", "gridConnectivity", "openAccessReadiness", "tariffType", "contractTenureYears", "codConfidence", "financialModelAvailable", "fundingStatus", cin, "keyContact", leadership, "loiScope", notes, "portfolioCapacity", "referenceNo") FROM stdin;
ipp_1791901322469	Hinduja Renewables Pvt. Ltd.	Hinduja Renewables Pvt. Ltd. Limited	Mumbai, Maharashtra, India	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:02.487	2026-10-13 14:22:02.547	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	U40100MH2013PTC244506	Shashikant Ranjan / Animesh Sharma / Nikhil Mathews	Deepak Thakur	Entire JSMA	Engagement: Date provided; time pending\nMeeting date: 15 Oct 2026\nTime: Change in plan. Coming by road and will be reaching by 12.30 p.m. Lunch at Jalna	3 - 5 GWp	2
ipp_1791901322663	Lumara Energy (Brookfield backing stated in source)	Lumara Energy (Brookfield backing stated in source) Limited	Mumbai, Maharashtra, India	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:02.669	2026-10-13 14:22:02.7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	U40106MH2023PTC396764	Mr. Vignesh	Vignesh Nandakumar	Entire JSMA	Engagement: Awaiting confirmation\nMeeting date: 22 Oct 2026	6 GWp	3
ipp_1791901322213	SAEL Industries Limited	SAEL Industries Limited Limited	Delhi, India	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:02.225	2026-10-13 14:22:02.306	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	U40106PB2022PLC055755	Mr. Laxit Awla / Ms. Sylvia	Jasbir Awla	Entire JSMA	Engagement: Date provided; time pending\nMeeting date: 17 Oct 2026\nProfile: https://drive.google.com/drive/folders/1sTjbHKboC_GSTlbIAuo5erYjVd7D0vfi?usp=sharing	8.5 GWp	1
ipp_1791901322836	Fourth Partner Energy Limited	Fourth Partner Energy Limited Limited	Hyderabad, Telangana, India	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:02.841	2026-10-13 14:22:02.867	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	U40108TG2010PTC070806	PT Devraj / Sivasis Sen	Saif Dhorajiwala / Vivek Subramanian	Entire JSMA	Engagement: Awaiting confirmation\nMeeting date: 20 Oct 2026	3.5 GWp	4
ipp_1791901322977	Alfanar Power	Alfanar Power Limited	Gurgaon, Haryana, India	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:02.984	2026-10-13 14:22:03.013	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	U45500HR2018FTC076004	Mr. Mohamed Irfan	Abdulsalam Al Mutlaq / Sabah Al Mutlaq	Entire JSMA	Engagement: Not interested	1.75 GWp	5
ipp_1791901323132	Sirius Renewables Power Pvt. Ltd.	Sirius Renewables Power Pvt. Ltd. Limited	Gurgaon, Haryana, India	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:03.137	2026-10-13 14:22:03.166	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	U40106RJ2022PTC085404	Mr. Rohit Pandey / Mr. Harsh Bharadwaj	Devendra Singh / Kanhaiya Somani	Entire JSMA	Engagement: Awaiting confirmation	2 GWp	6
ipp_1791901323285	TrueRE / Oriana Power Limited	TrueRE / Oriana Power Limited Limited	Noida, Uttar Pradesh	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:03.29	2026-10-13 14:22:03.317	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	L35101DL2013PLC248685	Aniruddha Saraswat, Amit Jain & Pravin Kumar	Rupal Gupta	Entire JSMA	Engagement: Date provided; time pending\nMeeting date: 21 Oct 2026	+1 GWp	7
ipp_1791901323443	Amplus (Gentari) Renewables Limited	Amplus (Gentari) Renewables Limited Limited	Gurgaon, Haryana, India	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:03.448	2026-10-13 14:22:03.472	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	U40104DL2013PTC292262	Mr. Himanshu Shivam	Sharad Pungalia	Entire JSMA	Engagement: Date provided; time pending\nMeeting date: 16 Oct 2026	7.5 GWp	8
ipp_1791901323592	Apraava Energy	Apraava Energy Limited	Andheri, Mumbai, Maharashtra, India	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:03.599	2026-10-13 14:22:03.628	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	U40100DL1992PTC416841	Mr. shalab shrivastava and Mr. Jogendra behera	Rajiv Ranjan Mishra	Entire JSMA	Engagement: Declined after name disclosure	2 GWp	9
ipp_1791901323738	Serentica Renewables	Serentica Renewables Limited	Gurgaon, Haryana, India	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:03.743	2026-10-13 14:22:03.766	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	U74110HR2014PTC101972	Mr. Sushant Satish	Akshay Hiranandani	Entire JSMA	Engagement: Awaiting confirmation	3 GWp	10
ipp_1791901323881	Refex Renewables & Infrastructure Ltd.	Refex Renewables & Infrastructure Ltd. Limited	Chennai, Tamil Nadu, India - 600034	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:03.886	2026-10-13 14:22:03.909	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	L40100TN1994PLC028263	To be verified	Anil Jain / Kalpesh Kumar	Entire JSMA	Engagement: No response after name disclosure	To be verified	11
ipp_1791901324035	GMR Renewable Energy Limited	GMR Renewable Energy Limited Limited	Mumbai, Maharashtra, India - 400051	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:04.04	2026-10-13 14:22:04.068	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	U40104MH2010PLC282702	Mr. Nagesh sayam	G. M. Rao / Srinivas Bommidala	Entire JSMA	Engagement: Awaiting confirmation	3 GWp	12
ipp_1791901324175	Goldi Solar Pvt. Ltd.	Goldi Solar Pvt. Ltd. Limited	Surat, Gujarat - 395008	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:04.18	2026-10-13 14:22:04.204	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	U40100MH2011PLC350073	To be verified	Ishver Dholakiya / Bharat Bhut	Entire JSMA (solar only)	Engagement: Phase 2	15 GWp (Manufacturing)	13
ipp_1791901324322	ReNew Energy	ReNew Energy Limited	Haryana, India - 122009	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:04.33	2026-10-13 14:22:04.361	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	U40300DL2011PTC291527	To be verified	Sumant Sinha	Partial JSMA requirement	Engagement: Budget unavailable until 2029	12.5 GWp	14
ipp_1791901324487	Razon Green	Razon Green Limited	Surat, Gujarat, India	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:04.493	2026-10-13 14:22:04.513	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	U43222GJ2023PTC139860	To be verified	Chirag Nakrani / Hardik Kothiya	Partial JSMA requirement	Engagement: Phase 2	To be verified	15
ipp_1791901324632	Sorigin Renewables	Sorigin Renewables Limited	Gurugram / Delhi NCR	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:04.636	2026-10-13 14:22:04.663	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	U42201PN2022FTC211647	To be verified	Subhash K. / Sandeep Sharma	Partial JSMA requirement	Engagement: Phase 2	6 GWp	16
ipp_1791901324785	Ozas Green (Ojas Green Energy Private Limited)	Ozas Green (Ojas Green Energy Private Limited) Limited	Andhra Pradesh, India - 518001	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:04.789	2026-10-13 14:22:04.822	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	U35105AP2025PTC118811	To be verified	B. V. S. Reddy	Partial JSMA requirement	Engagement: Excluded by NewRa	To be verified	17
ipp_1791901324956	Zetwerk Renewable Energy	Zetwerk Renewable Energy Limited	Bengaluru, Karnataka, India - 560001	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:04.962	2026-10-13 14:22:04.986	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	U74999KA2017PLC128777	To be verified	Amrit Acharya / Abhay Adya	Partial JSMA requirement	Engagement: Phase 2	1.6 GWp	18
ipp_1791901325112	Solenco Infra	Solenco Infra Limited	Mumbai, Maharashtra, India - 400070	Solar	0	0	0	0	1	0	1	2030	IPP_EVALUATION	Evaluator	t	{"bessMw": 0, "bessMwh": 0, "windCuf": 0, "solarCuf": 0, "baseScores": {"cod": 4, "ehv": 4, "epc": 4, "fdre": 4, "capex": 4, "tariff": 4, "execution": 4, "financial": 4, "regulatory": 4, "engineering": 4}, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "weakSystemStudy": false, "capexCredibility": 3.72, "scadaIntegration": "PLANNED", "dataQualityFactor": 1}	2026-10-13 14:22:05.116	2026-10-13 14:22:05.147	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	U40106MH2018PTC316123	Mr. Pradeep shah and Mr. Sushil vohra	Ashish Mehta	Partial JSMA requirement	Engagement: Excluded by NewRa	300 MW	19
\.


--
-- Data for Name: IPPBESSProfile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPBESSProfile" (id, "ippId", "powerMw", "energyMwh", "usableEnergyMwh", "durationHours", chemistry, oem, pcs, ems, "roundTripEfficiency", "depthOfDischarge", "cycleCapability", availability, degradation, augmentation, "yearSnapshots", "augmentationPayer", "dispatchOwner", "socMin", "socMax", warranty, "performanceGuarantee", evidences, "dataQuality") FROM stdin;
cmv6rs5pk003j146g0jlsm2k1	ipp_1791901322977	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs62g0061146g4ptems1l	ipp_1791901323443	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6ms00a7146gjfl7r5m3	ipp_1791901324175	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs73q00dj146gsdrba7wf	ipp_1791901324785	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6vi00bv146gol7z2rk8	ipp_1791901324487	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6qy00b1146gso41w3sm	ipp_1791901324322	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6em008j146go4mpl5o1	ipp_1791901323881	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs5tt004d146gzfx5jkr6	ipp_1791901323132	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6zh00cp146gwcvnscbe	ipp_1791901324632	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs5y20057146gjb9ejwvz	ipp_1791901323285	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs66n006v146gbzyepv25	ipp_1791901323592	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs5ll002p146gjxbl1zms	ipp_1791901322836	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6ix009d146g8i2syimf	ipp_1791901324035	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs5bt0011146gqjkxeho6	ipp_1791901322469	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs5gu001v146gv2n6jki2	ipp_1791901322663	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs54h0007146glzju4zeh	ipp_1791901322213	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6ao007p146g8bzqjd2l	ipp_1791901323738	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs7cs00f7146goe5vi7az	ipp_1791901325112	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs78i00ed146gzmzsa5q5	ipp_1791901324956	0	0	0	0	None	Declared at entry	Not applicable	Not applicable	1	0	0	0	\N	Not applicable	[{"year": 1, "usableMwh": 0}, {"year": 5, "usableMwh": 0}, {"year": 10, "usableMwh": 0}, {"year": 15, "usableMwh": 0}]	Not applicable	Not applicable	0.1	0.9	Not applicable	Not applicable	[{"unit": "hours", "field": "BESS duration", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "BESS duration sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
\.


--
-- Data for Name: IPPCapexItem; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPCapexItem" (id, "modelId", category, "amountInrCr", unit, source, evidence, "assumptionType", "evidenceStatus") FROM stdin;
cmv6rs54i000d146g66afaiob	cmv6rs54i000c146g3j31zivt	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs54i000e146gliulci77	cmv6rs54i000c146g3j31zivt	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs54i000f146gcoj4gvmk	cmv6rs54i000c146g3j31zivt	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs54i000g146goovca1uf	cmv6rs54i000c146g3j31zivt	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs54i000h146gfsiffxpv	cmv6rs54i000c146g3j31zivt	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs54i000i146g81zcbt7r	cmv6rs54i000c146g3j31zivt	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs54i000j146gfh3u6ptb	cmv6rs54i000c146g3j31zivt	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs54i000k146grkx97o36	cmv6rs54i000c146g3j31zivt	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs54i000l146gulbn1qkz	cmv6rs54i000c146g3j31zivt	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs54i000m146gym2v7x1p	cmv6rs54i000c146g3j31zivt	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs54i000n146g1h06ghcf	cmv6rs54i000c146g3j31zivt	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs54i000o146g6xxqvfjo	cmv6rs54i000c146g3j31zivt	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs54i000p146g7pph9uy1	cmv6rs54i000c146g3j31zivt	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs54i000q146gc0o80mcb	cmv6rs54i000c146g3j31zivt	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
cmv6rs5bv0017146gqxavfbci	cmv6rs5bu0016146ge554c6r3	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs5bv0018146g9eky6278	cmv6rs5bu0016146ge554c6r3	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs5bv0019146gzihsmy12	cmv6rs5bu0016146ge554c6r3	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs5bv001a146gdsbt64fk	cmv6rs5bu0016146ge554c6r3	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs5bv001b146g5hk3urdh	cmv6rs5bu0016146ge554c6r3	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs5bv001c146gzx1637lh	cmv6rs5bu0016146ge554c6r3	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs5bv001d146grvzoa59w	cmv6rs5bu0016146ge554c6r3	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs5bv001e146gpykkq2xi	cmv6rs5bu0016146ge554c6r3	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs5bv001f146gd85elxjb	cmv6rs5bu0016146ge554c6r3	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs5bv001g146gv7rzu4z1	cmv6rs5bu0016146ge554c6r3	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs5bv001h146gl6ifldvi	cmv6rs5bu0016146ge554c6r3	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs5bv001i146gbjgcbvez	cmv6rs5bu0016146ge554c6r3	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs5bv001j146gmvlqw2kz	cmv6rs5bu0016146ge554c6r3	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs5bv001k146g053mwp6w	cmv6rs5bu0016146ge554c6r3	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
cmv6rs5gv0021146g75vb8g46	cmv6rs5gv0020146ggv1upven	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs5gv0022146g2yh31cpw	cmv6rs5gv0020146ggv1upven	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs5gv0023146gasxkhovs	cmv6rs5gv0020146ggv1upven	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs5gv0024146gyusez81t	cmv6rs5gv0020146ggv1upven	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs5gv0025146gva4nhxt6	cmv6rs5gv0020146ggv1upven	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs5gv0026146g62ohpcp4	cmv6rs5gv0020146ggv1upven	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs5gv0027146gy9v2xkha	cmv6rs5gv0020146ggv1upven	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs5gv0028146gtvx1pd40	cmv6rs5gv0020146ggv1upven	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs5gv0029146gogebvwle	cmv6rs5gv0020146ggv1upven	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs5gv002a146gsoidw31w	cmv6rs5gv0020146ggv1upven	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs5gv002b146grhxlff1f	cmv6rs5gv0020146ggv1upven	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs5gv002c146gqx0os9ej	cmv6rs5gv0020146ggv1upven	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs5gv002d146gv3eld5b5	cmv6rs5gv0020146ggv1upven	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs5gv002e146g25js8d2e	cmv6rs5gv0020146ggv1upven	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
cmv6rs5lm002v146go5qtaz4n	cmv6rs5lm002u146g7h2nwdrj	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs5lm002w146gf0ia4gx6	cmv6rs5lm002u146g7h2nwdrj	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs5lm002x146g1btz2n4i	cmv6rs5lm002u146g7h2nwdrj	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs5lm002y146gezl1ef8p	cmv6rs5lm002u146g7h2nwdrj	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs5lm002z146gor8nyjmf	cmv6rs5lm002u146g7h2nwdrj	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs5lm0030146g1hl8seky	cmv6rs5lm002u146g7h2nwdrj	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs5lm0031146g7dj24vv2	cmv6rs5lm002u146g7h2nwdrj	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs5lm0032146gzm3ahjne	cmv6rs5lm002u146g7h2nwdrj	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs5lm0033146g4gumh7zj	cmv6rs5lm002u146g7h2nwdrj	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs5lm0034146gc4af6ovm	cmv6rs5lm002u146g7h2nwdrj	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs5lm0035146g9r5ksokg	cmv6rs5lm002u146g7h2nwdrj	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs5ln0036146gjhysf2ix	cmv6rs5lm002u146g7h2nwdrj	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs5ln0037146g2ahjzhzf	cmv6rs5lm002u146g7h2nwdrj	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs5ln0038146ga0s6rxnj	cmv6rs5lm002u146g7h2nwdrj	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
cmv6rs5pl003p146gsq8v5f8v	cmv6rs5pk003o146g0p9eiw07	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs5pl003q146gmar2rxfd	cmv6rs5pk003o146g0p9eiw07	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs5pl003r146g0tswc02b	cmv6rs5pk003o146g0p9eiw07	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs5pl003s146ggj10eucs	cmv6rs5pk003o146g0p9eiw07	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs5pl003t146gnilp2tnq	cmv6rs5pk003o146g0p9eiw07	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs5pl003u146gc3ytt5h7	cmv6rs5pk003o146g0p9eiw07	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs5pl003v146g7po77ums	cmv6rs5pk003o146g0p9eiw07	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs5pl003w146gd5zcdyqf	cmv6rs5pk003o146g0p9eiw07	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs5pl003x146gmd8bzpqq	cmv6rs5pk003o146g0p9eiw07	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs5pl003y146gkhgqdi7r	cmv6rs5pk003o146g0p9eiw07	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs5pl003z146gmrycvcna	cmv6rs5pk003o146g0p9eiw07	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs5pl0040146gr82qg7jb	cmv6rs5pk003o146g0p9eiw07	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs5pl0041146gw7xc0944	cmv6rs5pk003o146g0p9eiw07	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs5pl0042146griil6dbq	cmv6rs5pk003o146g0p9eiw07	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
cmv6rs5tu004j146gak9ersw0	cmv6rs5tu004i146gv0ne1s71	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs5tu004k146gf8goleip	cmv6rs5tu004i146gv0ne1s71	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs5tu004l146gh9uztlsp	cmv6rs5tu004i146gv0ne1s71	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs5tu004m146gpqxuc3vp	cmv6rs5tu004i146gv0ne1s71	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs5tu004n146gk3089s78	cmv6rs5tu004i146gv0ne1s71	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs5tu004o146gysg4y4de	cmv6rs5tu004i146gv0ne1s71	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs5tu004p146gz625q4h7	cmv6rs5tu004i146gv0ne1s71	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs5tu004q146gwu80kp27	cmv6rs5tu004i146gv0ne1s71	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs5tu004r146gm6msz7ox	cmv6rs5tu004i146gv0ne1s71	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs5tu004s146gwz3jhmqa	cmv6rs5tu004i146gv0ne1s71	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs5tu004t146gqadsl5kr	cmv6rs5tu004i146gv0ne1s71	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs5tu004u146g5v75lsmu	cmv6rs5tu004i146gv0ne1s71	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs5tu004v146gxf2821o4	cmv6rs5tu004i146gv0ne1s71	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs5tu004w146g2zbpqcaq	cmv6rs5tu004i146gv0ne1s71	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
cmv6rs5y2005d146gcword8xf	cmv6rs5y2005c146gtyfnjo88	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs5y2005e146g74xc22ut	cmv6rs5y2005c146gtyfnjo88	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs5y2005f146gou25btc4	cmv6rs5y2005c146gtyfnjo88	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs5y2005g146gbm7l65mq	cmv6rs5y2005c146gtyfnjo88	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs5y2005h146g7afivid1	cmv6rs5y2005c146gtyfnjo88	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs5y2005i146gho5l8y6d	cmv6rs5y2005c146gtyfnjo88	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs5y2005j146gn6ngs5sx	cmv6rs5y2005c146gtyfnjo88	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs5y2005k146guzw246l7	cmv6rs5y2005c146gtyfnjo88	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs5y2005l146g61soraak	cmv6rs5y2005c146gtyfnjo88	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs5y2005m146gp0ikn25a	cmv6rs5y2005c146gtyfnjo88	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs5y2005n146gwsnz9bhj	cmv6rs5y2005c146gtyfnjo88	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs5y2005o146gc97v21ny	cmv6rs5y2005c146gtyfnjo88	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs5y2005p146grhdt0zs0	cmv6rs5y2005c146gtyfnjo88	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs5y2005q146gyoa6aa1a	cmv6rs5y2005c146gtyfnjo88	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
cmv6rs62h0067146gtdmmxosk	cmv6rs62h0066146g8n8w66a5	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs62h0068146gkbckr04h	cmv6rs62h0066146g8n8w66a5	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs62h0069146g9kle8odd	cmv6rs62h0066146g8n8w66a5	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs62h006a146ggru55ovq	cmv6rs62h0066146g8n8w66a5	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs62h006b146g6mehm0gd	cmv6rs62h0066146g8n8w66a5	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs62h006c146grscym2kg	cmv6rs62h0066146g8n8w66a5	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs62h006d146gljrw06im	cmv6rs62h0066146g8n8w66a5	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs62h006e146g4dstxxvw	cmv6rs62h0066146g8n8w66a5	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs62h006f146goshg6acf	cmv6rs62h0066146g8n8w66a5	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs62h006g146gmik07fu3	cmv6rs62h0066146g8n8w66a5	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs62h006h146gqmpjmrjo	cmv6rs62h0066146g8n8w66a5	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs62h006i146grsmp7bov	cmv6rs62h0066146g8n8w66a5	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs62h006j146gnl73wi9d	cmv6rs62h0066146g8n8w66a5	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs62h006k146gzd9wkhs7	cmv6rs62h0066146g8n8w66a5	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
cmv6rs66o0071146g0p817ic2	cmv6rs66o0070146gszm77dcd	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs66o0072146gj8tbbd27	cmv6rs66o0070146gszm77dcd	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs66o0073146gjf80ll7x	cmv6rs66o0070146gszm77dcd	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs66o0074146gd97isn89	cmv6rs66o0070146gszm77dcd	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs66o0075146gsgduooef	cmv6rs66o0070146gszm77dcd	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs66o0076146gkcsckaag	cmv6rs66o0070146gszm77dcd	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs66o0077146g7ahkifjc	cmv6rs66o0070146gszm77dcd	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs66o0078146g2a64qyge	cmv6rs66o0070146gszm77dcd	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs66o0079146guukpu8io	cmv6rs66o0070146gszm77dcd	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs66o007a146gj54s84qe	cmv6rs66o0070146gszm77dcd	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs66o007b146gd50zkobz	cmv6rs66o0070146gszm77dcd	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs66o007c146g8xz69nx9	cmv6rs66o0070146gszm77dcd	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs66o007d146gz1uwkgdi	cmv6rs66o0070146gszm77dcd	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs66o007e146ghl08yqur	cmv6rs66o0070146gszm77dcd	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
cmv6rs6ao007v146gl6ds1gno	cmv6rs6ao007u146gdicrpn64	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs6ao007w146gnehkmp37	cmv6rs6ao007u146gdicrpn64	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs6ao007x146g4fyablqv	cmv6rs6ao007u146gdicrpn64	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs6ao007y146gxk34bbes	cmv6rs6ao007u146gdicrpn64	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs6ao007z146gkrifbr5y	cmv6rs6ao007u146gdicrpn64	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs6ao0080146g01ucoslg	cmv6rs6ao007u146gdicrpn64	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs6ao0081146gamkkflvq	cmv6rs6ao007u146gdicrpn64	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs6ao0082146guhy67eg1	cmv6rs6ao007u146gdicrpn64	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs6ao0083146ghbrdjodh	cmv6rs6ao007u146gdicrpn64	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs6ao0084146guh7wkvj8	cmv6rs6ao007u146gdicrpn64	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs6ao0085146gsgsn9o48	cmv6rs6ao007u146gdicrpn64	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs6ao0086146gpvcsnejx	cmv6rs6ao007u146gdicrpn64	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs6ao0087146gh6x38zpm	cmv6rs6ao007u146gdicrpn64	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs6ao0088146gs7cg7zfz	cmv6rs6ao007u146gdicrpn64	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
cmv6rs6en008p146gpddbhbtr	cmv6rs6en008o146g68ktr36p	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs6en008q146gg2thgtwj	cmv6rs6en008o146g68ktr36p	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs6en008r146gvsaiff25	cmv6rs6en008o146g68ktr36p	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs6en008s146gnlcwi0am	cmv6rs6en008o146g68ktr36p	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs6en008t146gxswflxle	cmv6rs6en008o146g68ktr36p	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs6en008u146g2qku89n3	cmv6rs6en008o146g68ktr36p	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs6en008v146gbzscooba	cmv6rs6en008o146g68ktr36p	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs6en008w146gka4m1086	cmv6rs6en008o146g68ktr36p	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs6en008x146g6o7k05s3	cmv6rs6en008o146g68ktr36p	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs6en008y146g6291zgfg	cmv6rs6en008o146g68ktr36p	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs6en008z146gzp6aqykr	cmv6rs6en008o146g68ktr36p	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs6en0090146gvm7cyoxn	cmv6rs6en008o146g68ktr36p	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs6en0091146g17mmr256	cmv6rs6en008o146g68ktr36p	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs6en0092146grp8qytog	cmv6rs6en008o146g68ktr36p	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
cmv6rs6ix009j146ggkc6zr1h	cmv6rs6ix009i146gl2rctvua	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs6ix009k146gljrwcf8c	cmv6rs6ix009i146gl2rctvua	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs6ix009l146gqtirs6r9	cmv6rs6ix009i146gl2rctvua	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs6ix009m146gcfbryfsg	cmv6rs6ix009i146gl2rctvua	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs6ix009n146g4li3cnf5	cmv6rs6ix009i146gl2rctvua	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs6ix009o146gxlybqhlz	cmv6rs6ix009i146gl2rctvua	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs6ix009p146gzhm4kp8r	cmv6rs6ix009i146gl2rctvua	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs6ix009q146gwi1j5vo2	cmv6rs6ix009i146gl2rctvua	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs6ix009r146ga2sio8fh	cmv6rs6ix009i146gl2rctvua	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs6ix009s146gwon7bnyc	cmv6rs6ix009i146gl2rctvua	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs6ix009t146gfh0ptk3y	cmv6rs6ix009i146gl2rctvua	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs6ix009u146gswiapgcu	cmv6rs6ix009i146gl2rctvua	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs6ix009v146gawhmsprp	cmv6rs6ix009i146gl2rctvua	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs6ix009w146gbn6a65gu	cmv6rs6ix009i146gl2rctvua	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
cmv6rs6mt00ad146g7t6ckt6o	cmv6rs6mt00ac146gtkfpx98m	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs6mt00ae146go13420fy	cmv6rs6mt00ac146gtkfpx98m	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs6mt00af146gik4gfb6i	cmv6rs6mt00ac146gtkfpx98m	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs6mt00ag146gwnjv5b2c	cmv6rs6mt00ac146gtkfpx98m	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs6mt00ah146geke6q7l6	cmv6rs6mt00ac146gtkfpx98m	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs6mt00ai146gln5q7yqx	cmv6rs6mt00ac146gtkfpx98m	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs6mt00aj146gba3w6v5c	cmv6rs6mt00ac146gtkfpx98m	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs6mt00ak146gmkb5h8h6	cmv6rs6mt00ac146gtkfpx98m	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs6mt00al146g6hglfpd2	cmv6rs6mt00ac146gtkfpx98m	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs6mt00am146gyiocm5xv	cmv6rs6mt00ac146gtkfpx98m	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs6mt00an146g93qfxjax	cmv6rs6mt00ac146gtkfpx98m	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs6mt00ao146gor6l4ahy	cmv6rs6mt00ac146gtkfpx98m	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs6mt00ap146gbg8k23og	cmv6rs6mt00ac146gtkfpx98m	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs6mt00aq146g1rte2ewf	cmv6rs6mt00ac146gtkfpx98m	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
cmv6rs6qz00b7146g36fv38n6	cmv6rs6qz00b6146gvxgfnpuw	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs6qz00b8146gf4zroaeg	cmv6rs6qz00b6146gvxgfnpuw	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs6qz00b9146gnsztteth	cmv6rs6qz00b6146gvxgfnpuw	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs6qz00ba146gyrbqqmue	cmv6rs6qz00b6146gvxgfnpuw	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs6qz00bb146gukouas84	cmv6rs6qz00b6146gvxgfnpuw	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs6qz00bc146g08plb1sf	cmv6rs6qz00b6146gvxgfnpuw	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs6qz00bd146gfv23cbic	cmv6rs6qz00b6146gvxgfnpuw	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs6qz00be146g9j0fdpdk	cmv6rs6qz00b6146gvxgfnpuw	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs6qz00bf146gbw1fjfhe	cmv6rs6qz00b6146gvxgfnpuw	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs6qz00bg146gmd62987o	cmv6rs6qz00b6146gvxgfnpuw	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs6qz00bh146gowimjosc	cmv6rs6qz00b6146gvxgfnpuw	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs6qz00bi146gh50omas9	cmv6rs6qz00b6146gvxgfnpuw	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs6qz00bj146gc9sseg8j	cmv6rs6qz00b6146gvxgfnpuw	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs6qz00bk146gs1qk3uqw	cmv6rs6qz00b6146gvxgfnpuw	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
cmv6rs6vi00c1146gwxo1aeda	cmv6rs6vi00c0146gtly3h8sg	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs6vi00c2146g2acp0m0n	cmv6rs6vi00c0146gtly3h8sg	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs6vj00c3146gddnkygsq	cmv6rs6vi00c0146gtly3h8sg	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs6vj00c4146gpbpbb7lm	cmv6rs6vi00c0146gtly3h8sg	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs6vj00c5146gxroxm4n6	cmv6rs6vi00c0146gtly3h8sg	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs6vj00c6146gcz8zc0vx	cmv6rs6vi00c0146gtly3h8sg	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs6vj00c7146g903cydad	cmv6rs6vi00c0146gtly3h8sg	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs6vj00c8146g65ix2o3f	cmv6rs6vi00c0146gtly3h8sg	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs6vj00c9146gsq31k0v5	cmv6rs6vi00c0146gtly3h8sg	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs6vj00ca146gtixlw5uf	cmv6rs6vi00c0146gtly3h8sg	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs6vj00cb146gtxjv9v3i	cmv6rs6vi00c0146gtly3h8sg	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs6vj00cc146gbcutksud	cmv6rs6vi00c0146gtly3h8sg	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs6vj00cd146gh4tgfpkp	cmv6rs6vi00c0146gtly3h8sg	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs6vj00ce146gqp59uny4	cmv6rs6vi00c0146gtly3h8sg	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
cmv6rs6zh00cv146gp4ewajke	cmv6rs6zh00cu146gdzn7su7r	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs6zh00cw146grv7i8xzp	cmv6rs6zh00cu146gdzn7su7r	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs6zh00cx146g4pzlbaxr	cmv6rs6zh00cu146gdzn7su7r	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs6zh00cy146g1y7i0kgr	cmv6rs6zh00cu146gdzn7su7r	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs6zh00cz146g4rebsdba	cmv6rs6zh00cu146gdzn7su7r	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs6zh00d0146gke9q9ozj	cmv6rs6zh00cu146gdzn7su7r	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs6zh00d1146git1hea16	cmv6rs6zh00cu146gdzn7su7r	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs6zh00d2146g38yqw69o	cmv6rs6zh00cu146gdzn7su7r	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs6zh00d3146gjxvxs6yz	cmv6rs6zh00cu146gdzn7su7r	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs6zh00d4146gpvl6xm9p	cmv6rs6zh00cu146gdzn7su7r	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs6zh00d5146g9wo0dsfy	cmv6rs6zh00cu146gdzn7su7r	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs6zh00d6146gms6z7gdj	cmv6rs6zh00cu146gdzn7su7r	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs6zh00d7146gi491eye8	cmv6rs6zh00cu146gdzn7su7r	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs6zh00d8146gcaapicdn	cmv6rs6zh00cu146gdzn7su7r	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
cmv6rs73r00dp146gfkwb1io4	cmv6rs73r00do146gt14souwc	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs73r00dq146gxg9iodpk	cmv6rs73r00do146gt14souwc	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs73r00dr146gbd9orjyq	cmv6rs73r00do146gt14souwc	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs73r00ds146ga5hw3a2e	cmv6rs73r00do146gt14souwc	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs73r00dt146gsiizmd4g	cmv6rs73r00do146gt14souwc	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs73r00du146gz5t4viqp	cmv6rs73r00do146gt14souwc	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs73r00dv146glxzf1i8q	cmv6rs73r00do146gt14souwc	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs73r00dw146gbkeb7om0	cmv6rs73r00do146gt14souwc	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs73r00dx146gs20fhxrj	cmv6rs73r00do146gt14souwc	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs73r00dy146gxkf4r24b	cmv6rs73r00do146gt14souwc	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs73r00dz146ghu6a8lkj	cmv6rs73r00do146gt14souwc	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs73r00e0146gn3ekd7u7	cmv6rs73r00do146gt14souwc	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs73r00e1146g8hd5bily	cmv6rs73r00do146gt14souwc	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs73r00e2146gfwip4ays	cmv6rs73r00do146gt14souwc	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
cmv6rs78j00ej146g7kwh77wg	cmv6rs78i00ei146g0vebii8c	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs78j00ek146grnpa9xxh	cmv6rs78i00ei146g0vebii8c	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs78j00el146ggdpfaszs	cmv6rs78i00ei146g0vebii8c	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs78j00em146gtfm9h5nq	cmv6rs78i00ei146g0vebii8c	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs78j00en146g46qlil01	cmv6rs78i00ei146g0vebii8c	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs78j00eo146go7yurm0r	cmv6rs78i00ei146g0vebii8c	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs78j00ep146g1zdd8vgp	cmv6rs78i00ei146g0vebii8c	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs78j00eq146gygjng3n7	cmv6rs78i00ei146g0vebii8c	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs78j00er146gh800xv5u	cmv6rs78i00ei146g0vebii8c	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs78j00es146gow2h5kp7	cmv6rs78i00ei146g0vebii8c	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs78j00et146gtn794yld	cmv6rs78i00ei146g0vebii8c	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs78j00eu146geua558hq	cmv6rs78i00ei146g0vebii8c	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs78j00ev146gtepg99ji	cmv6rs78i00ei146g0vebii8c	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs78j00ew146go78ymkko	cmv6rs78i00ei146g0vebii8c	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
cmv6rs7ct00fd146gbxsd9vcz	cmv6rs7ct00fc146guznisaqv	EPC	42.11	INR Cr	Entered with the IPP	EPC	INDICATIVE	UNDER_REVIEW
cmv6rs7ct00fe146gjodeqaa9	cmv6rs7ct00fc146guznisaqv	Pooling	18.42	INR Cr	Entered with the IPP	Pooling	INDICATIVE	UNDER_REVIEW
cmv6rs7ct00ff146gb1uj0a0m	cmv6rs7ct00fc146guznisaqv	Transmission	26.32	INR Cr	Entered with the IPP	Transmission	INDICATIVE	UNDER_REVIEW
cmv6rs7ct00fg146gptqfrcaj	cmv6rs7ct00fc146guznisaqv	Bay	10.53	INR Cr	Entered with the IPP	Bay	INDICATIVE	UNDER_REVIEW
cmv6rs7ct00fh146gzbd38tnk	cmv6rs7ct00fc146guznisaqv	SCADA	6.32	INR Cr	Entered with the IPP	SCADA	INDICATIVE	UNDER_REVIEW
cmv6rs7ct00fi146gpajda1uj	cmv6rs7ct00fc146guznisaqv	EMS	5.26	INR Cr	Entered with the IPP	EMS	INDICATIVE	UNDER_REVIEW
cmv6rs7ct00fj146g798pf6zf	cmv6rs7ct00fc146guznisaqv	Metering	4.21	INR Cr	Entered with the IPP	Metering	INDICATIVE	UNDER_REVIEW
cmv6rs7ct00fk146gr5pw0bj0	cmv6rs7ct00fc146guznisaqv	Civil	21.05	INR Cr	Entered with the IPP	Civil	INDICATIVE	UNDER_REVIEW
cmv6rs7ct00fl146gdgibd56y	cmv6rs7ct00fc146guznisaqv	Development	13.16	INR Cr	Entered with the IPP	Development	INDICATIVE	UNDER_REVIEW
cmv6rs7ct00fm146gybc64nsi	cmv6rs7ct00fc146guznisaqv	IDC	15.79	INR Cr	Entered with the IPP	IDC	INDICATIVE	UNDER_REVIEW
cmv6rs7ct00fn146gv3ag44tk	cmv6rs7ct00fc146guznisaqv	Taxes	13.16	INR Cr	Entered with the IPP	Taxes	INDICATIVE	UNDER_REVIEW
cmv6rs7ct00fo146g1mugkja8	cmv6rs7ct00fc146guznisaqv	Insurance	5.26	INR Cr	Entered with the IPP	Insurance	INDICATIVE	UNDER_REVIEW
cmv6rs7ct00fp146g0wz4nma2	cmv6rs7ct00fc146guznisaqv	Contingency	10.53	INR Cr	Entered with the IPP	Contingency	INDICATIVE	UNDER_REVIEW
cmv6rs7ct00fq146g8mbtes7v	cmv6rs7ct00fc146guznisaqv	Other CAPEX	7.89	INR Cr	Entered with the IPP	Other CAPEX	INDICATIVE	UNDER_REVIEW
\.


--
-- Data for Name: IPPCapexModel; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPCapexModel" (id, "ippId", "totalInrCr", "credibilityScore", "dataQuality") FROM stdin;
cmv6rs5pk003o146g0p9eiw07	ipp_1791901322977	200	3.72	PARTIAL
cmv6rs62h0066146g8n8w66a5	ipp_1791901323443	200	3.72	PARTIAL
cmv6rs66o0070146gszm77dcd	ipp_1791901323592	200	3.72	PARTIAL
cmv6rs5lm002u146g7h2nwdrj	ipp_1791901322836	200	3.72	PARTIAL
cmv6rs6ix009i146gl2rctvua	ipp_1791901324035	200	3.72	PARTIAL
cmv6rs6mt00ac146gtkfpx98m	ipp_1791901324175	200	3.72	PARTIAL
cmv6rs5bu0016146ge554c6r3	ipp_1791901322469	200	3.72	PARTIAL
cmv6rs5gv0020146ggv1upven	ipp_1791901322663	200	3.72	PARTIAL
cmv6rs73r00do146gt14souwc	ipp_1791901324785	200	3.72	PARTIAL
cmv6rs6vi00c0146gtly3h8sg	ipp_1791901324487	200	3.72	PARTIAL
cmv6rs6qz00b6146gvxgfnpuw	ipp_1791901324322	200	3.72	PARTIAL
cmv6rs6en008o146g68ktr36p	ipp_1791901323881	200	3.72	PARTIAL
cmv6rs54i000c146g3j31zivt	ipp_1791901322213	200	3.72	PARTIAL
cmv6rs6ao007u146gdicrpn64	ipp_1791901323738	200	3.72	PARTIAL
cmv6rs5tu004i146gv0ne1s71	ipp_1791901323132	200	3.72	PARTIAL
cmv6rs7ct00fc146guznisaqv	ipp_1791901325112	200	3.72	PARTIAL
cmv6rs6zh00cu146gdzn7su7r	ipp_1791901324632	200	3.72	PARTIAL
cmv6rs5y2005c146gtyfnjo88	ipp_1791901323285	200	3.72	PARTIAL
cmv6rs78i00ei146g0vebii8c	ipp_1791901324956	200	3.72	PARTIAL
\.


--
-- Data for Name: IPPEHVProfile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPEHVProfile" (id, "ippId", "kv132Experience", "kv220Experience", "stuCoordination", "sldcCoordination", "discomCoordination", "systemStudies", bay, pooling, protection, metering, communication, "rowStatus", "transmissionRouting", "connectivityStatus", "capabilityScore", "connectivityRisk", "evidenceStatus", evidences, "dataQuality") FROM stdin;
cmv6rs73q00dl146g80fops6m	ipp_1791901324785	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs6vi00bx146glwy2zvnd	ipp_1791901324487	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs6qy00b3146goi5rcrcs	ipp_1791901324322	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs7cs00f9146g1t3whvnf	ipp_1791901325112	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs6zh00cr146gbk8j5lqz	ipp_1791901324632	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs5pk003l146g1873zz0q	ipp_1791901322977	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs78i00ef146grf8d9ok1	ipp_1791901324956	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs5y20059146g6r69t34g	ipp_1791901323285	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs62h0063146gclru9ftc	ipp_1791901323443	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs66n006x146guv9mnoc0	ipp_1791901323592	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs5lm002r146g619c20va	ipp_1791901322836	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs6ix009f146glxx51hg1	ipp_1791901324035	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs6ms00a9146g6jp8p7t2	ipp_1791901324175	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs5bt0013146g6qi2c0eg	ipp_1791901322469	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs5gu001x146g2r1x774b	ipp_1791901322663	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs6em008l146g1qrcdr3q	ipp_1791901323881	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs54h0009146ggtkpucey	ipp_1791901322213	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs6ao007r146gyroz0lss	ipp_1791901323738	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs5tu004f146guezum1yq	ipp_1791901323132	t	f	To be studied	To be studied	To be studied	Scoped with the new record	Bay scope identified	Pooling in CAPEX	Specified	ABT metering specified	SCADA gateway specified	Route options open	Illustrative corridor	UNDER_STUDY	4	Moderate	UNDER_REVIEW	[{"unit": "UNDER_STUDY", "field": "Connectivity", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Connectivity sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
\.


--
-- Data for Name: IPPEPCProfile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPEPCProfile" (id, "ippId", contractor, commitment, "procurementStrategy", score) FROM stdin;
cmv6rs54h000a146gfjp3zphd	ipp_1791901322213	Named at entry	Indicative	Owner-procured long-lead	4
cmv6rs5bu0014146ggz8kl2dj	ipp_1791901322469	Named at entry	Indicative	Owner-procured long-lead	4
cmv6rs5gu001y146gnper9519	ipp_1791901322663	Named at entry	Indicative	Owner-procured long-lead	4
cmv6rs5lm002s146g6w3j549a	ipp_1791901322836	Named at entry	Indicative	Owner-procured long-lead	4
cmv6rs5pk003m146gbnixgzqw	ipp_1791901322977	Named at entry	Indicative	Owner-procured long-lead	4
cmv6rs5tu004g146g5tq06scm	ipp_1791901323132	Named at entry	Indicative	Owner-procured long-lead	4
cmv6rs5y2005a146g8ru6kr5e	ipp_1791901323285	Named at entry	Indicative	Owner-procured long-lead	4
cmv6rs62h0064146gv6nx2b7v	ipp_1791901323443	Named at entry	Indicative	Owner-procured long-lead	4
cmv6rs66n006y146gzzvmn28e	ipp_1791901323592	Named at entry	Indicative	Owner-procured long-lead	4
cmv6rs6ao007s146gy56ags9q	ipp_1791901323738	Named at entry	Indicative	Owner-procured long-lead	4
cmv6rs6em008m146gql8zf5e5	ipp_1791901323881	Named at entry	Indicative	Owner-procured long-lead	4
cmv6rs6ix009g146gdqfeigro	ipp_1791901324035	Named at entry	Indicative	Owner-procured long-lead	4
cmv6rs6ms00aa146g8v1d0p59	ipp_1791901324175	Named at entry	Indicative	Owner-procured long-lead	4
cmv6rs6qy00b4146gnn4f7a4r	ipp_1791901324322	Named at entry	Indicative	Owner-procured long-lead	4
cmv6rs6vi00by146gzymv27h3	ipp_1791901324487	Named at entry	Indicative	Owner-procured long-lead	4
cmv6rs6zh00cs146g6bemxwvi	ipp_1791901324632	Named at entry	Indicative	Owner-procured long-lead	4
cmv6rs73q00dm146gexjnfug8	ipp_1791901324785	Named at entry	Indicative	Owner-procured long-lead	4
cmv6rs78i00eg146glg3e4446	ipp_1791901324956	Named at entry	Indicative	Owner-procured long-lead	4
cmv6rs7cs00fa146gm240wjox	ipp_1791901325112	Named at entry	Indicative	Owner-procured long-lead	4
\.


--
-- Data for Name: IPPEvaluation; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPEvaluation" (id, "ippId", "overallScore", "dataQuality", confidence, "reviewerName", "calculatedAt") FROM stdin;
eval_ipp_1791901324035	ipp_1791901324035	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:11.364
eval_ipp_1791901324175	ipp_1791901324175	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:11.538
eval_ipp_1791901322469	ipp_1791901322469	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:11.731
eval_ipp_1791901322663	ipp_1791901322663	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:11.925
eval_ipp_1791901324785	ipp_1791901324785	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:12.103
eval_ipp_1791901324487	ipp_1791901324487	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:12.381
eval_ipp_1791901324322	ipp_1791901324322	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:12.72
eval_ipp_1791901323881	ipp_1791901323881	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:12.907
eval_ipp_1791901322213	ipp_1791901322213	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:13.101
eval_ipp_1791901323738	ipp_1791901323738	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:13.269
eval_ipp_1791901323132	ipp_1791901323132	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:13.445
eval_ipp_1791901325112	ipp_1791901325112	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:13.629
eval_ipp_1791901324632	ipp_1791901324632	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:13.82
eval_ipp_1791901323285	ipp_1791901323285	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:14.17
eval_ipp_1791901324956	ipp_1791901324956	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:14.331
eval_ipp_1791901322977	ipp_1791901322977	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:10.496
eval_ipp_1791901323443	ipp_1791901323443	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:10.745
eval_ipp_1791901323592	ipp_1791901323592	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:10.949
eval_ipp_1791901322836	ipp_1791901322836	80	PARTIAL	1	NewRa evaluation service	2026-10-13 15:15:11.158
\.


--
-- Data for Name: IPPEvaluationParameter; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPEvaluationParameter" (id, "evaluationId", key, name, "shortLabel", score, weight, "normalizedScore", "weightedContribution", evidence, status, reviewer, "dataQuality") FROM stdin;
cmv6toh8c05k2mk3okj3uuw5m	eval_ipp_1791901322977	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6toh8n05k6mk3oyktc9upw	eval_ipp_1791901322977	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6toh8s05kamk3oq9jzjfq3	eval_ipp_1791901322977	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6toh8x05kemk3ob0d9aj2y	eval_ipp_1791901322977	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6toh9305kimk3obvu6ruph	eval_ipp_1791901322977	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6toh9b05kmmk3oq3oj8c11	eval_ipp_1791901322977	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6toh9h05kqmk3o778aks09	eval_ipp_1791901322977	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6toh9n05kumk3ogc8nlibx	eval_ipp_1791901322977	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6toh9s05kymk3ogb0gc4r7	eval_ipp_1791901322977	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6toh9x05l2mk3oezag6x42	eval_ipp_1791901322977	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
cmv6tohf005m2mk3o3favjz7p	eval_ipp_1791901323443	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6tohf805m6mk3o7jy1ywb5	eval_ipp_1791901323443	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6tohfd05mamk3ocaksh6pa	eval_ipp_1791901323443	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6tohfi05memk3onodvbtdd	eval_ipp_1791901323443	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6tohfn05mimk3o63rddrba	eval_ipp_1791901323443	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6tohfr05mmmk3okv19k2sp	eval_ipp_1791901323443	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6tohfw05mqmk3ore94pb6t	eval_ipp_1791901323443	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6tohg105mumk3ounpy5szo	eval_ipp_1791901323443	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6tohg505mymk3oiega8b4e	eval_ipp_1791901323443	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6tohg905n2mk3ouivdwsns	eval_ipp_1791901323443	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
cmv6tohqb05q2mk3owqtr8xbm	eval_ipp_1791901322836	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6tohqf05q6mk3o0fh6xkug	eval_ipp_1791901322836	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6tohqj05qamk3oifn6ali1	eval_ipp_1791901322836	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6tohqn05qemk3o2v8bo1a0	eval_ipp_1791901322836	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6tohqr05qimk3oc6swiwuc	eval_ipp_1791901322836	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6tohqu05qmmk3o3sya74iu	eval_ipp_1791901322836	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6tohqy05qqmk3orgrqigfx	eval_ipp_1791901322836	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6tohr305qumk3ohfbhjf3x	eval_ipp_1791901322836	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6tohr905qymk3ok2hjsssd	eval_ipp_1791901322836	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6tohrf05r2mk3o3runjzmn	eval_ipp_1791901322836	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
cmv6toi0x05u2mk3ox6fl69sg	eval_ipp_1791901324175	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6toi1205u6mk3ot6fvsda3	eval_ipp_1791901324175	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6toi1705uamk3onodpstd3	eval_ipp_1791901324175	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6toi1b05uemk3oiq43lixv	eval_ipp_1791901324175	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6toi1f05uimk3ogwwkwle7	eval_ipp_1791901324175	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6toi1k05ummk3owj6nl59v	eval_ipp_1791901324175	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6toi1o05uqmk3oyjnoa1x7	eval_ipp_1791901324175	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6toi1s05uumk3o8hay3ojv	eval_ipp_1791901324175	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6toi1v05uymk3o5t4yjhzp	eval_ipp_1791901324175	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6toi1z05v2mk3osjfp1mp3	eval_ipp_1791901324175	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
cmv6toibm05y2mk3oixuj997o	eval_ipp_1791901322663	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6toibq05y6mk3o0sdah5w0	eval_ipp_1791901322663	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6toibu05yamk3on6dr8afw	eval_ipp_1791901322663	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6toiby05yemk3ofjf3lewv	eval_ipp_1791901322663	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6toic305yimk3oukrkmpr8	eval_ipp_1791901322663	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6toic805ymmk3oy2lyesfm	eval_ipp_1791901322663	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6toice05yqmk3ouczmuv0t	eval_ipp_1791901322663	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6toicj05yumk3oiecdpaxr	eval_ipp_1791901322663	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6toico05yymk3obqtfh5xg	eval_ipp_1791901322663	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6toict05z2mk3o63xfrpcp	eval_ipp_1791901322663	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
cmv6toios0622mk3oib8tomuh	eval_ipp_1791901324487	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6toip40626mk3os4wj2vp7	eval_ipp_1791901324487	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6toipg062amk3o2befv708	eval_ipp_1791901324487	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6toipt062emk3oyiaifs9p	eval_ipp_1791901324487	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6tohkm05o2mk3oeisfb57h	eval_ipp_1791901323592	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6tohkr05o6mk3ojn3qxqcf	eval_ipp_1791901323592	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6tohkv05oamk3odx69atsm	eval_ipp_1791901323592	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6tohl005oemk3omalrmziy	eval_ipp_1791901323592	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6tohl505oimk3owja008uh	eval_ipp_1791901323592	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6tohl905ommk3ouqfjcyju	eval_ipp_1791901323592	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6tohle05oqmk3oifkud7p9	eval_ipp_1791901323592	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6tohli05oumk3ohvdg50a2	eval_ipp_1791901323592	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6tohlm05oymk3oxtl006my	eval_ipp_1791901323592	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6tohlq05p2mk3o2kwvcnyt	eval_ipp_1791901323592	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
cmv6tohw305s2mk3onz9e76n4	eval_ipp_1791901324035	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6tohw705s6mk3oarzih6nw	eval_ipp_1791901324035	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6tohwb05samk3og3eumhkh	eval_ipp_1791901324035	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6tohwf05semk3o3qxzt11k	eval_ipp_1791901324035	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6tohwj05simk3oqqxdp3si	eval_ipp_1791901324035	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6tohwn05smmk3o9bw251mc	eval_ipp_1791901324035	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6tohwr05sqmk3o3myvoih1	eval_ipp_1791901324035	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6tohwv05sumk3osm80hydd	eval_ipp_1791901324035	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6tohwy05symk3oqpyqxmfl	eval_ipp_1791901324035	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6tohx205t2mk3otxq44hi6	eval_ipp_1791901324035	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
cmv6toi6805w2mk3ov6vqek4h	eval_ipp_1791901322469	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6toi6c05w6mk3oz9cvynio	eval_ipp_1791901322469	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6toi6g05wamk3o3atka9lk	eval_ipp_1791901322469	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6toi6j05wemk3ocsbbsqgb	eval_ipp_1791901322469	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6toi6n05wimk3osewb652g	eval_ipp_1791901322469	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6toi6r05wmmk3ocd9b0gtc	eval_ipp_1791901322469	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6toi6v05wqmk3orrr5t9i1	eval_ipp_1791901322469	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6toi6y05wumk3otzya73vq	eval_ipp_1791901322469	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6toi7205wymk3o8ufgfx9x	eval_ipp_1791901322469	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6toi7605x2mk3owpyrtsfu	eval_ipp_1791901322469	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
cmv6toigm0602mk3o0ohkime6	eval_ipp_1791901324785	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6toigq0606mk3ogdij4joo	eval_ipp_1791901324785	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6toigv060amk3oo54tpmso	eval_ipp_1791901324785	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6toih1060emk3ofyrr8848	eval_ipp_1791901324785	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6toih9060imk3opqdzn993	eval_ipp_1791901324785	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6toihf060mmk3o38y1edvo	eval_ipp_1791901324785	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6toihl060qmk3ov2q9etyf	eval_ipp_1791901324785	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6toihp060umk3oy9fv0i9o	eval_ipp_1791901324785	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6toiht060ymk3oovxhoxiw	eval_ipp_1791901324785	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6toihw0612mk3oemo0baya	eval_ipp_1791901324785	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
cmv6toixp0642mk3oek6amk14	eval_ipp_1791901324322	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6toixt0646mk3oplavma2g	eval_ipp_1791901324322	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6toixx064amk3oh18ctn1i	eval_ipp_1791901324322	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6toiy1064emk3on0d9ovul	eval_ipp_1791901324322	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6toiy4064imk3ojp8lzjjr	eval_ipp_1791901324322	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6toiy8064mmk3o5dcf5mq6	eval_ipp_1791901324322	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6toiyc064qmk3o9h0b9m3l	eval_ipp_1791901324322	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6toiyg064umk3o3ab9i32a	eval_ipp_1791901324322	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6toiyk064ymk3octrct02w	eval_ipp_1791901324322	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6toiyo0652mk3on6sqod31	eval_ipp_1791901324322	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
cmv6toj890682mk3oh2ze2bhr	eval_ipp_1791901322213	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6toj8c0686mk3oqdgp9ks4	eval_ipp_1791901322213	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6toj8h068amk3o220nx8ac	eval_ipp_1791901322213	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6toj8k068emk3o5tmn2cm2	eval_ipp_1791901322213	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6toj8o068imk3oi9opcv6p	eval_ipp_1791901322213	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6toj8s068mmk3oepny0o3b	eval_ipp_1791901322213	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6toj8w068qmk3ochls0ciq	eval_ipp_1791901322213	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6toj91068umk3oq54w42an	eval_ipp_1791901322213	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6toj95068ymk3ota7q4ood	eval_ipp_1791901322213	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6toj990692mk3op6l5py36	eval_ipp_1791901322213	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
cmv6tojhu06c2mk3oe6nvy98z	eval_ipp_1791901323132	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6tojhz06c6mk3oxv5psul3	eval_ipp_1791901323132	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6toji406camk3orkqkr2e2	eval_ipp_1791901323132	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6toji806cemk3on0w3ysae	eval_ipp_1791901323132	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6tojid06cimk3ogk5ere0s	eval_ipp_1791901323132	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6tojii06cmmk3oce2h1i4o	eval_ipp_1791901323132	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6tojim06cqmk3ox9mf3pjz	eval_ipp_1791901323132	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6tojiq06cumk3ojqtd2dp5	eval_ipp_1791901323132	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6tojiu06cymk3ot3zg6ie2	eval_ipp_1791901323132	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6tojiz06d2mk3ov6zd8xu5	eval_ipp_1791901323132	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
cmv6tojs806g2mk3ocapbyuo0	eval_ipp_1791901324632	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6tojsd06g6mk3oi2b8x6gc	eval_ipp_1791901324632	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6tojsg06gamk3ok1tbannz	eval_ipp_1791901324632	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6tojsk06gemk3ozjtqe2pu	eval_ipp_1791901324632	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6toiq6062imk3og581kosf	eval_ipp_1791901324487	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6toiqi062mmk3o2d6ivya7	eval_ipp_1791901324487	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6toiqv062qmk3oijxo4wae	eval_ipp_1791901324487	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6toir6062umk3ouau32us8	eval_ipp_1791901324487	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6toirh062ymk3okcy6edcs	eval_ipp_1791901324487	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6toirt0632mk3o0wpsuu8v	eval_ipp_1791901324487	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
cmv6toj2y0662mk3om0gu520n	eval_ipp_1791901323881	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6toj330666mk3oc0qgh9w9	eval_ipp_1791901323881	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6toj37066amk3o5ivrealo	eval_ipp_1791901323881	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6toj3c066emk3owdas1e37	eval_ipp_1791901323881	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6toj3f066imk3o0vqit7hy	eval_ipp_1791901323881	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6toj3j066mmk3obqefhjpi	eval_ipp_1791901323881	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6toj3n066qmk3o1iv5vcyj	eval_ipp_1791901323881	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6toj3r066umk3om4ea40el	eval_ipp_1791901323881	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6toj3v066ymk3on3jfndkr	eval_ipp_1791901323881	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6toj3z0672mk3ou2hcw2dx	eval_ipp_1791901323881	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
cmv6tojcx06a2mk3ocs7u5gbh	eval_ipp_1791901323738	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6tojd106a6mk3ogyrypw1l	eval_ipp_1791901323738	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6tojd506aamk3ot79vqdek	eval_ipp_1791901323738	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6tojd906aemk3omjdzmhim	eval_ipp_1791901323738	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6tojdc06aimk3o1zabaegt	eval_ipp_1791901323738	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6tojdg06ammk3ojrvt2czx	eval_ipp_1791901323738	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6tojdk06aqmk3oxt3ascgc	eval_ipp_1791901323738	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6tojdo06aumk3on8gg0ro9	eval_ipp_1791901323738	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6tojds06aymk3o0kz9nr2u	eval_ipp_1791901323738	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6tojdw06b2mk3o1jdgbxh9	eval_ipp_1791901323738	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
cmv6tojmy06e2mk3odylmze1x	eval_ipp_1791901325112	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6tojn206e6mk3oflwt6z97	eval_ipp_1791901325112	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6tojn606eamk3ooa9wm81x	eval_ipp_1791901325112	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6tojnb06eemk3olslq45b7	eval_ipp_1791901325112	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6tojnf06eimk3o51cgvz6j	eval_ipp_1791901325112	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6tojnj06emmk3o90jb6bqu	eval_ipp_1791901325112	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6tojnn06eqmk3odpt1itsp	eval_ipp_1791901325112	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6tojnr06eumk3oufownurk	eval_ipp_1791901325112	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6tojnu06eymk3olwn7igo8	eval_ipp_1791901325112	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6tojny06f2mk3oy9ugthh9	eval_ipp_1791901325112	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
cmv6tok6h06m1mk3o8nmx6ehh	eval_ipp_1791901324956	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6tojso06gimk3ohw3nroh4	eval_ipp_1791901324632	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6tojss06gmmk3ok05mhl84	eval_ipp_1791901324632	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6tojsw06gqmk3o6yt0bpif	eval_ipp_1791901324632	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6tojt006gumk3oxvhxb1a9	eval_ipp_1791901324632	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6tojt406gymk3oz6kl2fmd	eval_ipp_1791901324632	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6tojt806h2mk3oe0qqtocr	eval_ipp_1791901324632	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
cmv6tok1y06k1mk3oslimchhd	eval_ipp_1791901323285	execution	IPP Execution Track Record	Execution	4	10	80	8	Commissioning record received	PASS	Technical Team	COMPLETE
cmv6tok2206k5mk3obgpheu2i	eval_ipp_1791901323285	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6tok2506k9mk3o2xjht6x2	eval_ipp_1791901323285	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6tok2906kdmk3o9d0z5bbj	eval_ipp_1791901323285	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6tok2d06khmk3ogzqosv3g	eval_ipp_1791901323285	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6tok2h06klmk3ompjccybd	eval_ipp_1791901323285	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6tok2l06kpmk3oqfea1j37	eval_ipp_1791901323285	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6tok2p06ktmk3oqh4m0oar	eval_ipp_1791901323285	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6tok2t06kxmk3o2i5edoxg	eval_ipp_1791901323285	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6tok2w06l1mk3ozlnl8iyf	eval_ipp_1791901323285	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
cmv6tok6n06m5mk3o0dszheb2	eval_ipp_1791901324956	financial	Financial Strength & Funding Capability	Financial	4	10	80	8	Funding capability note received	PASS	Finance Team	COMPLETE
cmv6tok6r06m9mk3ofb0pd6p2	eval_ipp_1791901324956	ehv	EHV Connectivity & Evacuation Execution Capability	EHV	4	10	80	8	Evacuation experience note received	PASS	Technical Team	COMPLETE
cmv6tok6v06mdmk3ou9tme2wz	eval_ipp_1791901324956	engineering	Technical Engineering Capability	Engineering	4	10	80	8	Design basis received	PASS	Technical Team	COMPLETE
cmv6tok6y06mhmk3oac4gghkf	eval_ipp_1791901324956	fdre	FDRE / 15-Minute Load Matching Capability	FDRE	4	10	80	8	Generation profile received	PASS	Technical Team	COMPLETE
cmv6tok7206mlmk3ozl9ibq2h	eval_ipp_1791901324956	epc	EPC & Procurement Capability	EPC	4	10	80	8	Procurement plan received	PASS	Technical Team	COMPLETE
cmv6tok7506mpmk3o0w4mdvbe	eval_ipp_1791901324956	cod	Project Execution & COD Certainty	COD	4	15	80	12	Schedule received	PASS	Technical Team	COMPLETE
cmv6tok7906mtmk3oruv7zu92	eval_ipp_1791901324956	capex	CAPEX Model Credibility	CAPEX	4	10	80	8	CAPEX build-up received	PASS	Finance Team	COMPLETE
cmv6tok7d06mxmk3oz7j4demy	eval_ipp_1791901324956	tariff	PPA Pricing Sustainability	Tariff	4	10	80	8	Tariff proposal received	PASS	Commercial Team	COMPLETE
cmv6tok7i06n1mk3onzs527l8	eval_ipp_1791901324956	regulatory	Regulatory & Contractual Protection	Regulatory	4	5	80	4	Contractual mark-up received	PASS	Commercial Team	COMPLETE
\.


--
-- Data for Name: IPPEvaluationScore; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPEvaluationScore" (id, "evaluationId", key, "baseScore", "appliedScore", reason) FROM stdin;
cmv6toh8i05k4mk3ojkzplwp9	eval_ipp_1791901322977	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toh8p05k8mk3o4be52erq	eval_ipp_1791901322977	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toh8u05kcmk3ony9nvbo0	eval_ipp_1791901322977	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toh9005kgmk3o5rnl9cz6	eval_ipp_1791901322977	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toh9605kkmk3ov8k6iklq	eval_ipp_1791901322977	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toh9e05komk3onnw3ijgp	eval_ipp_1791901322977	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toh9k05ksmk3oruj8eav8	eval_ipp_1791901322977	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toh9q05kwmk3oyhhlz3kg	eval_ipp_1791901322977	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toh9v05l0mk3o0q63b2lr	eval_ipp_1791901322977	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toh9z05l4mk3orhwvy9ir	eval_ipp_1791901322977	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohf405m4mk3obmv80b1v	eval_ipp_1791901323443	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohfb05m8mk3ozqyx8f64	eval_ipp_1791901323443	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohff05mcmk3oo3kceppu	eval_ipp_1791901323443	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohfk05mgmk3o5uskm5jv	eval_ipp_1791901323443	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohfp05mkmk3oyx4ikp8l	eval_ipp_1791901323443	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohfu05momk3o5vbsfnyb	eval_ipp_1791901323443	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohfy05msmk3o8ulfoocu	eval_ipp_1791901323443	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohg305mwmk3o2laydtmf	eval_ipp_1791901323443	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohg705n0mk3o21tesmc8	eval_ipp_1791901323443	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohgb05n4mk3oezhzjt7k	eval_ipp_1791901323443	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohkp05o4mk3oqcorscs7	eval_ipp_1791901323592	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohkt05o8mk3oyrgezpkv	eval_ipp_1791901323592	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohky05ocmk3okqagiojb	eval_ipp_1791901323592	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohl205ogmk3ogsxlnmvw	eval_ipp_1791901323592	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohl705okmk3oumoirbgh	eval_ipp_1791901323592	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohlb05oomk3oyt0tgcyj	eval_ipp_1791901323592	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohlg05osmk3o79o1hnzs	eval_ipp_1791901323592	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohlk05owmk3ot785klms	eval_ipp_1791901323592	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohlo05p0mk3ozn6qqc35	eval_ipp_1791901323592	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohlt05p4mk3o12khdves	eval_ipp_1791901323592	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohqd05q4mk3o7mlnhy8d	eval_ipp_1791901322836	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohqh05q8mk3ol56bvl1h	eval_ipp_1791901322836	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohql05qcmk3opgolqwwf	eval_ipp_1791901322836	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohqp05qgmk3on8k37e1h	eval_ipp_1791901322836	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohqt05qkmk3owjadexcz	eval_ipp_1791901322836	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohqw05qomk3ojb9q6vc7	eval_ipp_1791901322836	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohr105qsmk3oizptrs1m	eval_ipp_1791901322836	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohr605qwmk3o7tobdzb9	eval_ipp_1791901322836	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohrc05r0mk3o71g786lb	eval_ipp_1791901322836	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohri05r4mk3ogmgzvxun	eval_ipp_1791901322836	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohw505s4mk3oca6wjit1	eval_ipp_1791901324035	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohwa05s8mk3oyqjzfvvt	eval_ipp_1791901324035	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohwd05scmk3oanoo8dlf	eval_ipp_1791901324035	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohwh05sgmk3oescc91d7	eval_ipp_1791901324035	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohwl05skmk3okf67e6w4	eval_ipp_1791901324035	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohwp05somk3oask3iidk	eval_ipp_1791901324035	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohwt05ssmk3okvt3yz7x	eval_ipp_1791901324035	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohwx05swmk3ocecd4edr	eval_ipp_1791901324035	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohx005t0mk3ou5wxe8y6	eval_ipp_1791901324035	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tohx405t4mk3oxayj1x35	eval_ipp_1791901324035	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi6a05w4mk3opgv7con4	eval_ipp_1791901322469	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi6e05w8mk3o1u6h250u	eval_ipp_1791901322469	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi6i05wcmk3o3m7dy48p	eval_ipp_1791901322469	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi6l05wgmk3oebxc103t	eval_ipp_1791901322469	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi6p05wkmk3oz90btnsl	eval_ipp_1791901322469	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi6t05womk3oidy5h4x2	eval_ipp_1791901322469	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi6x05wsmk3omveqt12e	eval_ipp_1791901322469	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi7005wwmk3ow4okvivh	eval_ipp_1791901322469	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi7405x0mk3oi4d2zqhd	eval_ipp_1791901322469	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi7805x4mk3oq73psqwz	eval_ipp_1791901322469	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toigo0604mk3oz4xuifhi	eval_ipp_1791901324785	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toigs0608mk3o1msjyzyr	eval_ipp_1791901324785	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toigy060cmk3o202qyyje	eval_ipp_1791901324785	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toih6060gmk3ocob51tq1	eval_ipp_1791901324785	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toihd060kmk3od44fezif	eval_ipp_1791901324785	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toihi060omk3oqjzf4wzn	eval_ipp_1791901324785	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toihn060smk3onhu4blna	eval_ipp_1791901324785	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toihr060wmk3oilt10moh	eval_ipp_1791901324785	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toihu0610mk3owzruoxzb	eval_ipp_1791901324785	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toihy0614mk3oovw0nwdn	eval_ipp_1791901324785	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toixr0644mk3o7yg6kvcz	eval_ipp_1791901324322	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toixv0648mk3oehysoqt2	eval_ipp_1791901324322	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toixz064cmk3o1iuodawg	eval_ipp_1791901324322	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toiy2064gmk3o1z7lvuu0	eval_ipp_1791901324322	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toiy6064kmk3oceomkxnd	eval_ipp_1791901324322	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toiya064omk3o4sozyp2v	eval_ipp_1791901324322	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toiye064smk3obxiexfga	eval_ipp_1791901324322	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toiyi064wmk3oenn1yt3a	eval_ipp_1791901324322	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toiym0650mk3opd2lfsy5	eval_ipp_1791901324322	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toiyq0654mk3ouwt97dkz	eval_ipp_1791901324322	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj8a0684mk3o0dt8lnjs	eval_ipp_1791901322213	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj8f0688mk3oqeowzbw4	eval_ipp_1791901322213	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj8i068cmk3ogkejo1qw	eval_ipp_1791901322213	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj8m068gmk3odhlwey99	eval_ipp_1791901322213	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj8q068kmk3ogdqv9mts	eval_ipp_1791901322213	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj8u068omk3o9msceexy	eval_ipp_1791901322213	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj8y068smk3o4tnklvn7	eval_ipp_1791901322213	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj93068wmk3oio3omv2i	eval_ipp_1791901322213	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj960690mk3ox0778oqg	eval_ipp_1791901322213	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj9a0694mk3oa04bdg5j	eval_ipp_1791901322213	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojhw06c4mk3ox3nk1lko	eval_ipp_1791901323132	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toji206c8mk3o5ts58ci3	eval_ipp_1791901323132	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi0z05u4mk3ob8rnri9k	eval_ipp_1791901324175	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi1505u8mk3o47yiti3t	eval_ipp_1791901324175	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi1905ucmk3onirejgef	eval_ipp_1791901324175	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi1d05ugmk3op71wrt0e	eval_ipp_1791901324175	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi1h05ukmk3ouoyhhwlt	eval_ipp_1791901324175	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi1m05uomk3onflranvi	eval_ipp_1791901324175	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi1q05usmk3oecdwjft8	eval_ipp_1791901324175	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi1u05uwmk3o126knf0u	eval_ipp_1791901324175	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi1y05v0mk3onitqb7yz	eval_ipp_1791901324175	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toi2105v4mk3o4j05pg27	eval_ipp_1791901324175	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toibo05y4mk3ocit9nxp9	eval_ipp_1791901322663	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toibs05y8mk3ots5mcdvw	eval_ipp_1791901322663	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toibw05ycmk3o6l3b9wu3	eval_ipp_1791901322663	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toic105ygmk3ow26clao9	eval_ipp_1791901322663	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toic605ykmk3ovooybomn	eval_ipp_1791901322663	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toicb05yomk3okgos1tv0	eval_ipp_1791901322663	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toich05ysmk3osb2r8msc	eval_ipp_1791901322663	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toicm05ywmk3ophvdb59m	eval_ipp_1791901322663	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toicq05z0mk3okrziih12	eval_ipp_1791901322663	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toicv05z4mk3oo02rwvj2	eval_ipp_1791901322663	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toioy0624mk3omxib6587	eval_ipp_1791901324487	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toipa0628mk3orhkuuyd4	eval_ipp_1791901324487	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toipm062cmk3ovqby4mxd	eval_ipp_1791901324487	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toiq0062gmk3otwn22rd8	eval_ipp_1791901324487	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toiqc062kmk3ows5pu17a	eval_ipp_1791901324487	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toiqo062omk3omsvg343f	eval_ipp_1791901324487	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toir0062smk3ovdwqx5g6	eval_ipp_1791901324487	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toirb062wmk3oh1ftjor8	eval_ipp_1791901324487	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toirn0630mk3ot77i26ht	eval_ipp_1791901324487	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toirz0634mk3o4tlohxcv	eval_ipp_1791901324487	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj300664mk3osat27y7a	eval_ipp_1791901323881	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj350668mk3on4fpnc6e	eval_ipp_1791901323881	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj3a066cmk3o1jc5ei7x	eval_ipp_1791901323881	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj3d066gmk3o4q68aq8g	eval_ipp_1791901323881	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj3h066kmk3onexfnoe1	eval_ipp_1791901323881	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj3l066omk3ojt17vk5q	eval_ipp_1791901323881	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj3p066smk3ocgqpw0cz	eval_ipp_1791901323881	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj3u066wmk3o4ug952me	eval_ipp_1791901323881	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj3x0670mk3opvyvwxzw	eval_ipp_1791901323881	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toj410674mk3oh6n8riro	eval_ipp_1791901323881	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojcz06a4mk3ofv5wr8xd	eval_ipp_1791901323738	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojd206a8mk3o5agdp7io	eval_ipp_1791901323738	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojd706acmk3orwv7cwln	eval_ipp_1791901323738	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojdb06agmk3oeelr68zo	eval_ipp_1791901323738	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojde06akmk3o886seffa	eval_ipp_1791901323738	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojdi06aomk3oq0txatkl	eval_ipp_1791901323738	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojdm06asmk3oj1td5ozj	eval_ipp_1791901323738	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojdq06awmk3o2uivaq4d	eval_ipp_1791901323738	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojdu06b0mk3o5vr0mkb7	eval_ipp_1791901323738	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojdy06b4mk3ob2ng14m8	eval_ipp_1791901323738	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojn006e4mk3ollotnqg7	eval_ipp_1791901325112	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojn406e8mk3oqinjksns	eval_ipp_1791901325112	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojn906ecmk3opj254ike	eval_ipp_1791901325112	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojnd06egmk3oiw15f92p	eval_ipp_1791901325112	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojnh06ekmk3oz8818mqf	eval_ipp_1791901325112	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojnl06eomk3o7v74vstj	eval_ipp_1791901325112	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojnp06esmk3owy5a4si4	eval_ipp_1791901325112	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojnt06ewmk3ole36aeha	eval_ipp_1791901325112	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojnw06f0mk3ob8dbmkgu	eval_ipp_1791901325112	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojo006f4mk3ollze1ena	eval_ipp_1791901325112	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok6j06m3mk3orre1wbyq	eval_ipp_1791901324956	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok6p06m7mk3ojba3gr8r	eval_ipp_1791901324956	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok6t06mbmk3oxtw74ytl	eval_ipp_1791901324956	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok6w06mfmk3oc03e49by	eval_ipp_1791901324956	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok7006mjmk3oq7qlpimk	eval_ipp_1791901324956	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok7406mnmk3obf6626cj	eval_ipp_1791901324956	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok7706mrmk3oywdayrlf	eval_ipp_1791901324956	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok7b06mvmk3oyii7bdfy	eval_ipp_1791901324956	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok7f06mzmk3ogtzbk029	eval_ipp_1791901324956	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok7k06n3mk3o0tnfbi0b	eval_ipp_1791901324956	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6toji606ccmk3o45hwg6s5	eval_ipp_1791901323132	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojib06cgmk3on36qax78	eval_ipp_1791901323132	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojig06ckmk3omu7lnz0h	eval_ipp_1791901323132	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojik06comk3ofjaz5pr7	eval_ipp_1791901323132	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojio06csmk3oah2ets6b	eval_ipp_1791901323132	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojis06cwmk3o6wa2weun	eval_ipp_1791901323132	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojiw06d0mk3ohxnsygly	eval_ipp_1791901323132	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojj106d4mk3oiwn39nfw	eval_ipp_1791901323132	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojsb06g4mk3op74cc5mx	eval_ipp_1791901324632	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojsf06g8mk3oza512dnq	eval_ipp_1791901324632	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojsi06gcmk3o38shjnzf	eval_ipp_1791901324632	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojsm06ggmk3ou1dq6rjy	eval_ipp_1791901324632	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojsq06gkmk3o86dwgypn	eval_ipp_1791901324632	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojsu06gomk3oennt7wpx	eval_ipp_1791901324632	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojsy06gsmk3o6xghzjkv	eval_ipp_1791901324632	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojt206gwmk3on2uw6oz2	eval_ipp_1791901324632	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojt606h0mk3ojlt74vpi	eval_ipp_1791901324632	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tojta06h4mk3oyteug0cf	eval_ipp_1791901324632	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok2006k3mk3ot0wlvzmn	eval_ipp_1791901323285	execution	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok2406k7mk3o1b2gexaz	eval_ipp_1791901323285	financial	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok2706kbmk3oehensatp	eval_ipp_1791901323285	ehv	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok2c06kfmk3oyxhiszkz	eval_ipp_1791901323285	engineering	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok2f06kjmk3oqad2ec6r	eval_ipp_1791901323285	fdre	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok2j06knmk3ofysqrjjg	eval_ipp_1791901323285	epc	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok2n06krmk3ojuhpk47f	eval_ipp_1791901323285	cod	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok2r06kvmk3otw00rjae	eval_ipp_1791901323285	capex	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok2u06kzmk3o3lswg9p2	eval_ipp_1791901323285	tariff	4	4	Calculated from base score and input movement versus the seeded baseline
cmv6tok2y06l3mk3owrxrjyzk	eval_ipp_1791901323285	regulatory	4	4	Calculated from base score and input movement versus the seeded baseline
\.


--
-- Data for Name: IPPExecutionSchedule; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPExecutionSchedule" (id, "ippId", milestones, "criticalPath", "longestLeadItem", "regulatoryDependency", "procurementDependency", "financingDependency", "projectBufferMonths", "internalCod", "contractualCod", "downsideCod", "hasCpm", "procurementAligned", "connectivityAssumed", "epcCommitted") FROM stdin;
cmv6rs5bu0015146gdeyctk2v	ipp_1791901322469	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
cmv6rs5gu001z146gzw8bqn2c	ipp_1791901322663	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
cmv6rs5pk003n146gh72jb0bw	ipp_1791901322977	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
cmv6rs5lm002t146g3ah6b7jf	ipp_1791901322836	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
cmv6rs5tu004h146goa4e0f66	ipp_1791901323132	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
cmv6rs62h0065146gn1pie8aw	ipp_1791901323443	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
cmv6rs66n006z146g0d41klke	ipp_1791901323592	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
cmv6rs6em008n146g6m4cuosy	ipp_1791901323881	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
cmv6rs6ix009h146gixp5pza1	ipp_1791901324035	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
cmv6rs6mt00ab146g5kdl1dqu	ipp_1791901324175	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
cmv6rs6vi00bz146gv6mm22hs	ipp_1791901324487	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
cmv6rs73q00dn146go279as30	ipp_1791901324785	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
cmv6rs7cs00fb146gt8e2z0b8	ipp_1791901325112	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
cmv6rs6zh00ct146g9t7sgluu	ipp_1791901324632	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
cmv6rs6qy00b5146g5zs32spd	ipp_1791901324322	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
cmv6rs54h000b146gwndd3vwe	ipp_1791901322213	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
cmv6rs6ao007t146gh05gk6c4	ipp_1791901323738	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
cmv6rs5y2005b146gltra54cj	ipp_1791901323285	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
cmv6rs78i00eh146glu29gufk	ipp_1791901324956	[{"name": "Detailed Engineering", "endDay": 49, "startDay": 0, "durationDays": 49, "leadTimeDays": 30}, {"name": "Connectivity Application", "endDay": 98, "startDay": 49, "durationDays": 49, "leadTimeDays": 31}, {"name": "System Studies", "endDay": 147, "startDay": 98, "durationDays": 49, "leadTimeDays": 32}, {"name": "Connectivity Approval", "endDay": 196, "startDay": 147, "durationDays": 49, "leadTimeDays": 180}, {"name": "Financial Closure", "endDay": 245, "startDay": 196, "durationDays": 49, "leadTimeDays": 34}, {"name": "EPC Appointment", "endDay": 294, "startDay": 245, "durationDays": 49, "leadTimeDays": 35}, {"name": "Major Procurement", "endDay": 418, "startDay": 294, "durationDays": 124, "leadTimeDays": 240}, {"name": "Civil Works", "endDay": 467, "startDay": 418, "durationDays": 49, "leadTimeDays": 37}, {"name": "Evacuation Construction", "endDay": 591, "startDay": 467, "durationDays": 124, "leadTimeDays": 38}, {"name": "Equipment Delivery", "endDay": 640, "startDay": 591, "durationDays": 49, "leadTimeDays": 39}, {"name": "Substation Readiness", "endDay": 689, "startDay": 640, "durationDays": 49, "leadTimeDays": 40}, {"name": "Mechanical Completion", "endDay": 738, "startDay": 689, "durationDays": 49, "leadTimeDays": 41}, {"name": "Electrical Completion", "endDay": 787, "startDay": 738, "durationDays": 49, "leadTimeDays": 42}, {"name": "Synchronization", "endDay": 836, "startDay": 787, "durationDays": 49, "leadTimeDays": 43}, {"name": "Trial Operation", "endDay": 885, "startDay": 836, "durationDays": 49, "leadTimeDays": 44}, {"name": "COD", "endDay": 934, "startDay": 885, "durationDays": 49, "leadTimeDays": 45}]	["Detailed Engineering", "Connectivity Application", "System Studies", "Connectivity Approval", "Financial Closure", "EPC Appointment", "Major Procurement", "Civil Works", "Evacuation Construction", "Equipment Delivery", "Substation Readiness", "Mechanical Completion", "Electrical Completion", "Synchronization", "Trial Operation", "COD"]	Major Procurement (240 days)	Connectivity approval	Main equipment	Lender sanction	4	2030-03-31 00:00:00	2030-03-31 00:00:00	2030-09-30 00:00:00	t	t	f	t
\.


--
-- Data for Name: IPPExperience; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPExperience" (id, "ippId", "commissionedMw", "yearsOperating", "projectsCompleted", "notableProjects") FROM stdin;
cmv6rs54h0003146giqv4eu1g	ipp_1791901322213	0	11	7	Operating and under-construction renewable capacity in western and southern India.
cmv6rs5bs000x146g56xyikpt	ipp_1791901322469	0	11	7	Operating and under-construction renewable capacity in western and southern India.
cmv6rs5gu001r146gevbmzn0h	ipp_1791901322663	0	11	7	Operating and under-construction renewable capacity in western and southern India.
cmv6rs5ll002l146gnz81onhw	ipp_1791901322836	0	11	7	Operating and under-construction renewable capacity in western and southern India.
cmv6rs5pk003f146gvkvmzvqm	ipp_1791901322977	0	11	7	Operating and under-construction renewable capacity in western and southern India.
cmv6rs5tt0049146g8i9ekc0c	ipp_1791901323132	0	11	7	Operating and under-construction renewable capacity in western and southern India.
cmv6rs5y20053146gybtpqudo	ipp_1791901323285	0	11	7	Operating and under-construction renewable capacity in western and southern India.
cmv6rs62g005x146guc11dgt8	ipp_1791901323443	0	11	7	Operating and under-construction renewable capacity in western and southern India.
cmv6rs66n006r146g3fvsf5ez	ipp_1791901323592	0	11	7	Operating and under-construction renewable capacity in western and southern India.
cmv6rs6an007l146gseb7ym8e	ipp_1791901323738	0	11	7	Operating and under-construction renewable capacity in western and southern India.
cmv6rs6em008f146gjma8cir7	ipp_1791901323881	0	11	7	Operating and under-construction renewable capacity in western and southern India.
cmv6rs6iw0099146goxdwgg8x	ipp_1791901324035	0	11	7	Operating and under-construction renewable capacity in western and southern India.
cmv6rs6ms00a3146ggjtks3z1	ipp_1791901324175	0	11	7	Operating and under-construction renewable capacity in western and southern India.
cmv6rs6qy00ax146gtbe8n8ot	ipp_1791901324322	0	11	7	Operating and under-construction renewable capacity in western and southern India.
cmv6rs6vh00br146gq1azgv4c	ipp_1791901324487	0	11	7	Operating and under-construction renewable capacity in western and southern India.
cmv6rs6zg00cl146gjfswvjdb	ipp_1791901324632	0	11	7	Operating and under-construction renewable capacity in western and southern India.
cmv6rs73p00df146gonqvnavu	ipp_1791901324785	0	11	7	Operating and under-construction renewable capacity in western and southern India.
cmv6rs78i00e9146gjrzd9l3i	ipp_1791901324956	0	11	7	Operating and under-construction renewable capacity in western and southern India.
cmv6rs7cs00f3146gzkw5nzd0	ipp_1791901325112	0	11	7	Operating and under-construction renewable capacity in western and southern India.
\.


--
-- Data for Name: IPPFinancialModel; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPFinancialModel" (id, "ippId", "debtInrCr", "equityInrCr", "debtEquityRatio", "interestRate", "loanTenureYears", "moratoriumYears", dscr, "equityRequirementInrCr", "projectIrr", "equityIrr", "financialClosureDate", "lenderExperience", "lenderIdentified", "fundraisingDependency", "refinancingAssumptions", "capabilityScore", "dataQuality", "financingScheduleMismatch") FROM stdin;
cmv6rs6qz00bl146g37gho7bs	ipp_1791901324322	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
cmv6rs5pl0043146gu0thi9rv	ipp_1791901322977	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
cmv6rs62h006l146g2vvx4r3e	ipp_1791901323443	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
cmv6rs66o007f146gmzu7u8fl	ipp_1791901323592	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
cmv6rs5ln0039146ghptpphb7	ipp_1791901322836	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
cmv6rs6iy009x146g96z779nw	ipp_1791901324035	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
cmv6rs6mt00ar146gngycexiq	ipp_1791901324175	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
cmv6rs5bw001l146gnpiyd8v4	ipp_1791901322469	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
cmv6rs6en0093146g5843j703	ipp_1791901323881	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
cmv6rs5gv002f146gzvkyedwy	ipp_1791901322663	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
cmv6rs73r00e3146gpgxdu5uq	ipp_1791901324785	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
cmv6rs6vj00cf146gdx8o2hd6	ipp_1791901324487	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
cmv6rs54i000r146gk8ahxcpq	ipp_1791901322213	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
cmv6rs6ao0089146gahnc4laf	ipp_1791901323738	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
cmv6rs5tu004x146gctjwt5u7	ipp_1791901323132	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
cmv6rs7ct00fr146gjnitptdq	ipp_1791901325112	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
cmv6rs6zh00d9146g4jjzrzz1	ipp_1791901324632	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
cmv6rs5y3005r146grbwrjjo7	ipp_1791901323285	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
cmv6rs78j00ex146g7idtjiyt	ipp_1791901324956	146.16	60	2.33	0.09	18	0.5	0.001	60	-52.89	150	2028-06-30 00:00:00	Entered with the IPP	t	f	No refinance assumed	2.5	PARTIAL	f
\.


--
-- Data for Name: IPPGenerationProfile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPGenerationProfile" (id, "ippId", "p50Gwh", "p75Gwh", "p90Gwh", "resourceDatabase", "siteMeasurements", "independentValidation", monthly, intervals, evidences, "dataQuality") FROM stdin;
cmv6rs66n006w146gwpyd6nlf	ipp_1791901323592	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs6ao007q146gpxxpxowd	ipp_1791901323738	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs5y20058146g2ya6mflq	ipp_1791901323285	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs6ix009e146g4acmjqfy	ipp_1791901324035	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs6em008k146g486zoudt	ipp_1791901323881	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs6ms00a8146g54uglze8	ipp_1791901324175	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs6vi00bw146ga5zk70xk	ipp_1791901324487	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs6qy00b2146gs7u5anu1	ipp_1791901324322	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs6zh00cq146gxhzym523	ipp_1791901324632	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs78i00ee146gwdu0tpzb	ipp_1791901324956	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs5pk003k146gwskggd1m	ipp_1791901322977	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs5bt0012146g1t2415ef	ipp_1791901322469	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs73q00dk146g2l4ccmgp	ipp_1791901324785	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs5tt004e146gzu910eix	ipp_1791901323132	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs62h0062146gitcmoyxr	ipp_1791901323443	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs7cs00f8146gerzocyhz	ipp_1791901325112	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs5lm002q146glj20c6bf	ipp_1791901322836	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs5gu001w146gkh7r7gsq	ipp_1791901322663	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
cmv6rs54h0008146gl3mc1y91	ipp_1791901322213	1	0.5	0	Illustrative mesoscale archive	Entered with the IPP record	PENDING	[{"gwh": 0.06, "month": "Jan"}, {"gwh": 0.06, "month": "Feb"}, {"gwh": 0.07, "month": "Mar"}, {"gwh": 0.08, "month": "Apr"}, {"gwh": 0.1, "month": "May"}, {"gwh": 0.12, "month": "Jun"}, {"gwh": 0.13, "month": "Jul"}, {"gwh": 0.12, "month": "Aug"}, {"gwh": 0.09, "month": "Sep"}, {"gwh": 0.07, "month": "Oct"}, {"gwh": 0.05, "month": "Nov"}, {"gwh": 0.05, "month": "Dec"}]	[{"t": "00:00", "mw": 0}, {"t": "00:15", "mw": 0}, {"t": "00:30", "mw": 0}, {"t": "00:45", "mw": 0}, {"t": "01:00", "mw": 0}, {"t": "01:15", "mw": 0}, {"t": "01:30", "mw": 0}, {"t": "01:45", "mw": 0}, {"t": "02:00", "mw": 0}, {"t": "02:15", "mw": 0}, {"t": "02:30", "mw": 0}, {"t": "02:45", "mw": 0}, {"t": "03:00", "mw": 0}, {"t": "03:15", "mw": 0}, {"t": "03:30", "mw": 0}, {"t": "03:45", "mw": 0}, {"t": "04:00", "mw": 0}, {"t": "04:15", "mw": 0}, {"t": "04:30", "mw": 0}, {"t": "04:45", "mw": 0}, {"t": "05:00", "mw": 0}, {"t": "05:15", "mw": 0}, {"t": "05:30", "mw": 0}, {"t": "05:45", "mw": 0}, {"t": "06:00", "mw": 0}, {"t": "06:15", "mw": 0}, {"t": "06:30", "mw": 0}, {"t": "06:45", "mw": 0}, {"t": "07:00", "mw": 0}, {"t": "07:15", "mw": 0}, {"t": "07:30", "mw": 0}, {"t": "07:45", "mw": 0}, {"t": "08:00", "mw": 0}, {"t": "08:15", "mw": 0}, {"t": "08:30", "mw": 0}, {"t": "08:45", "mw": 0}, {"t": "09:00", "mw": 0}, {"t": "09:15", "mw": 0}, {"t": "09:30", "mw": 0}, {"t": "09:45", "mw": 0}, {"t": "10:00", "mw": 0}, {"t": "10:15", "mw": 0}, {"t": "10:30", "mw": 0}, {"t": "10:45", "mw": 0}, {"t": "11:00", "mw": 0}, {"t": "11:15", "mw": 0}, {"t": "11:30", "mw": 0}, {"t": "11:45", "mw": 0}, {"t": "12:00", "mw": 0}, {"t": "12:15", "mw": 0}, {"t": "12:30", "mw": 0}, {"t": "12:45", "mw": 0}, {"t": "13:00", "mw": 0}, {"t": "13:15", "mw": 0}, {"t": "13:30", "mw": 0}, {"t": "13:45", "mw": 0}, {"t": "14:00", "mw": 0}, {"t": "14:15", "mw": 0}, {"t": "14:30", "mw": 0}, {"t": "14:45", "mw": 0}, {"t": "15:00", "mw": 0}, {"t": "15:15", "mw": 0}, {"t": "15:30", "mw": 0}, {"t": "15:45", "mw": 0}, {"t": "16:00", "mw": 0}, {"t": "16:15", "mw": 0}, {"t": "16:30", "mw": 0}, {"t": "16:45", "mw": 0}, {"t": "17:00", "mw": 0}, {"t": "17:15", "mw": 0}, {"t": "17:30", "mw": 0}, {"t": "17:45", "mw": 0}, {"t": "18:00", "mw": 0}, {"t": "18:15", "mw": 0}, {"t": "18:30", "mw": 0}, {"t": "18:45", "mw": 0}, {"t": "19:00", "mw": 0}, {"t": "19:15", "mw": 0}, {"t": "19:30", "mw": 0}, {"t": "19:45", "mw": 0}, {"t": "20:00", "mw": 0}, {"t": "20:15", "mw": 0}, {"t": "20:30", "mw": 0}, {"t": "20:45", "mw": 0}, {"t": "21:00", "mw": 0}, {"t": "21:15", "mw": 0}, {"t": "21:30", "mw": 0}, {"t": "21:45", "mw": 0}, {"t": "22:00", "mw": 0}, {"t": "22:15", "mw": 0}, {"t": "22:30", "mw": 0}, {"t": "22:45", "mw": 0}, {"t": "23:00", "mw": 0}, {"t": "23:15", "mw": 0}, {"t": "23:30", "mw": 0}, {"t": "23:45", "mw": 0}]	[{"unit": "GWh", "field": "P90 generation", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "P90 generation sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	PARTIAL
\.


--
-- Data for Name: IPPProject; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPProject" (id, "ippId", name, state, "capacityMw", "codYear", status) FROM stdin;
cmv6rs54h0002146gmkjzzq1d	ipp_1791901322213	SAEL Industries Limited illustrative portfolio	Delhi, India	0	2030	Development
cmv6rs5bs000w146g7tnsgist	ipp_1791901322469	Hinduja Renewables Pvt. Ltd. illustrative portfolio	Mumbai, Maharashtra, India	0	2030	Development
cmv6rs5gt001q146gcx2enyyj	ipp_1791901322663	Lumara Energy (Brookfield backing stated in source) illustrative portfolio	Mumbai, Maharashtra, India	0	2030	Development
cmv6rs5ll002k146gejwrrlvb	ipp_1791901322836	Fourth Partner Energy Limited illustrative portfolio	Hyderabad, Telangana, India	0	2030	Development
cmv6rs5pk003e146gq87e52an	ipp_1791901322977	Alfanar Power illustrative portfolio	Gurgaon, Haryana, India	0	2030	Development
cmv6rs5tt0048146gb2fnsu7z	ipp_1791901323132	Sirius Renewables Power Pvt. Ltd. illustrative portfolio	Gurgaon, Haryana, India	0	2030	Development
cmv6rs5y20052146gr5vocjzv	ipp_1791901323285	TrueRE / Oriana Power Limited illustrative portfolio	Noida, Uttar Pradesh	0	2030	Development
cmv6rs62g005w146gqlwycp4c	ipp_1791901323443	Amplus (Gentari) Renewables Limited illustrative portfolio	Gurgaon, Haryana, India	0	2030	Development
cmv6rs66n006q146grqzcomre	ipp_1791901323592	Apraava Energy illustrative portfolio	Andheri, Mumbai, Maharashtra, India	0	2030	Development
cmv6rs6an007k146gt5vy92j5	ipp_1791901323738	Serentica Renewables illustrative portfolio	Gurgaon, Haryana, India	0	2030	Development
cmv6rs6em008e146gy5tzcfva	ipp_1791901323881	Refex Renewables & Infrastructure Ltd. illustrative portfolio	Chennai, Tamil Nadu, India - 600034	0	2030	Development
cmv6rs6iw0098146g6lzyltu6	ipp_1791901324035	GMR Renewable Energy Limited illustrative portfolio	Mumbai, Maharashtra, India - 400051	0	2030	Development
cmv6rs6ms00a2146guax8mkn5	ipp_1791901324175	Goldi Solar Pvt. Ltd. illustrative portfolio	Surat, Gujarat - 395008	0	2030	Development
cmv6rs6qy00aw146glvnhgb8m	ipp_1791901324322	ReNew Energy illustrative portfolio	Haryana, India - 122009	0	2030	Development
cmv6rs6vh00bq146gll17tulj	ipp_1791901324487	Razon Green illustrative portfolio	Surat, Gujarat, India	0	2030	Development
cmv6rs6zg00ck146gow57aq0i	ipp_1791901324632	Sorigin Renewables illustrative portfolio	Gurugram / Delhi NCR	0	2030	Development
cmv6rs73p00de146g851qugk1	ipp_1791901324785	Ozas Green (Ojas Green Energy Private Limited) illustrative portfolio	Andhra Pradesh, India - 518001	0	2030	Development
cmv6rs78i00e8146gum3i3w2z	ipp_1791901324956	Zetwerk Renewable Energy illustrative portfolio	Bengaluru, Karnataka, India - 560001	0	2030	Development
cmv6rs7cs00f2146g0ftgusrk	ipp_1791901325112	Solenco Infra illustrative portfolio	Mumbai, Maharashtra, India - 400070	0	2030	Development
\.


--
-- Data for Name: IPPRegulatoryProfile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPRegulatoryProfile" (id, "ippId", items, "protectionScore", "changeInLaw", curtailment, indemnity, "complianceBearer", "delayBearer", "dataQuality") FROM stdin;
cmv6rs5pl0045146guplylnws	ipp_1791901322977	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
cmv6rs62h006n146guydnu5jg	ipp_1791901323443	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
cmv6rs66o007h146ghr2t1ttg	ipp_1791901323592	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
cmv6rs5ln003b146gwj3th73h	ipp_1791901322836	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
cmv6rs6iy009z146ghbp51wur	ipp_1791901324035	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
cmv6rs6mt00at146gx4s3osta	ipp_1791901324175	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
cmv6rs5bw001n146gf32yvr29	ipp_1791901322469	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
cmv6rs5gw002h146g7l6qe61d	ipp_1791901322663	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
cmv6rs73s00e5146g3htsnwhe	ipp_1791901324785	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
cmv6rs6vj00ch146gzglsfu2x	ipp_1791901324487	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
cmv6rs6qz00bn146g8dolmvn1	ipp_1791901324322	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
cmv6rs6en0095146g5yv7d9y9	ipp_1791901323881	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
cmv6rs54i000t146gnoqkrjog	ipp_1791901322213	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
cmv6rs6ap008b146gfy7a8e5x	ipp_1791901323738	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
cmv6rs5tu004z146ghkkb3kdk	ipp_1791901323132	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
cmv6rs7ct00ft146gnowv3d1a	ipp_1791901325112	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
cmv6rs6zi00db146gth9n100b	ipp_1791901324632	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
cmv6rs5y3005t146g2v2um4jz	ipp_1791901323285	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
cmv6rs78j00ez146gitvg3fwq	ipp_1791901324956	[]	4	SHARED	CLEAR	STRONG	IPP	IPP	PARTIAL
\.


--
-- Data for Name: IPPSolarProfile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPSolarProfile" (id, "ippId", "acMw", "dcMw", "dcAcRatio", "moduleTechnology", "inverterPhilosophy", cuf, degradation, clipping, "auxiliaryConsumption", availability, evidences, "dataQuality") FROM stdin;
cmv6rs54h0005146gijg36egr	ipp_1791901322213	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs5bs000z146gaewpnuo7	ipp_1791901322469	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs5gu001t146gwpeflqtq	ipp_1791901322663	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs5ll002n146gk8plj3g0	ipp_1791901322836	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs5pk003h146gixsxf1hj	ipp_1791901322977	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs5tt004b146gds89hz3d	ipp_1791901323132	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs5y20055146gizffic6h	ipp_1791901323285	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs62g005z146gdr5i51q2	ipp_1791901323443	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs66n006t146g63k70mbj	ipp_1791901323592	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6an007n146gawdh5e8y	ipp_1791901323738	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6em008h146gwfarm64y	ipp_1791901323881	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6iw009b146g6me6wvg6	ipp_1791901324035	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6ms00a5146gne35o2tt	ipp_1791901324175	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6qy00az146g45o4d6zj	ipp_1791901324322	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6vh00bt146go7u118iw	ipp_1791901324487	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6zg00cn146gvypb9y5r	ipp_1791901324632	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs73p00dh146ge1c4fzy1	ipp_1791901324785	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs78i00eb146glir4mkq9	ipp_1791901324956	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs7cs00f5146gde8mhywd	ipp_1791901325112	0	0	0	Not applicable	Not applicable	0	0.004	0.015	0.012	0.985	[{"unit": "%", "field": "Solar CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Solar CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
\.


--
-- Data for Name: IPPSuitability; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPSuitability" (id, "gesRequirementId", "ippId", "overallPct", "compatibilityStatus", "illustrativeSeedStatus", dimensions, "dataQuality", "blockedByGate", "calculatedAt") FROM stdin;
cmv6tohcm05lnmk3o56pz6yqv	req_ges_1791904510208	ipp_1791901322977	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:10.496
cmv6tohod05pnmk3oekkttywm	req_ges_1791904510208	ipp_1791901323592	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:10.949
cmv6tohis05nnmk3ohoq79u07	req_ges_1791904510208	ipp_1791901323443	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:10.745
cmv6tohu205rnmk3o6rwsmsoo	req_ges_1791904510208	ipp_1791901322836	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:11.158
cmv6toi4805vnmk3ogv095osn	req_ges_1791904510208	ipp_1791901324175	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:11.538
cmv6toi9g05xnmk3olym6xs8s	req_ges_1791904510208	ipp_1791901322469	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:11.731
cmv6toiez05znmk3oz63mysxs	req_ges_1791904510208	ipp_1791901322663	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:11.925
cmv6tohzh05tnmk3oq6z8shaz	req_ges_1791904510208	ipp_1791901324035	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:11.364
cmv6toikh061nmk3onplihkj7	req_ges_1791904510208	ipp_1791901324785	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:12.103
cmv6toj0z065nmk3obemo5vig	req_ges_1791904510208	ipp_1791901324322	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:12.72
cmv6tojbd069nmk3oib7lpa01	req_ges_1791904510208	ipp_1791901322213	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:13.101
cmv6tojl906dnmk3orgz32h1h	req_ges_1791904510208	ipp_1791901323132	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:13.445
cmv6tojvd06hnmk3oqyv5a2s3	req_ges_1791904510208	ipp_1791901324632	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:13.82
cmv6toivj063nmk3oimxg0i14	req_ges_1791904510208	ipp_1791901324487	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:12.381
cmv6toj6a067nmk3o0r4mxoag	req_ges_1791904510208	ipp_1791901323881	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:12.907
cmv6tojg006bnmk3ogxo2u42b	req_ges_1791904510208	ipp_1791901323738	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:13.269
cmv6tojqa06fnmk3orgfthp0b	req_ges_1791904510208	ipp_1791901325112	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:13.629
cmv6tok5106lmmk3oipm5mwbs	req_ges_1791904510208	ipp_1791901323285	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:14.17
cmv6tok9p06nmmk3o3jmz7bmv	req_ges_1791904510208	ipp_1791901324956	49.73	GATE_FAILED	CONDITIONAL	[{"key": "energyCoverage", "label": "Energy Coverage", "score": 0, "weight": 14, "contribution": 0}, {"key": "loadMatch", "label": "Load Matching", "score": 0, "weight": 16, "contribution": 0}, {"key": "technologyFit", "label": "Technology Fit", "score": 100, "weight": 10, "contribution": 10}, {"key": "bessFit", "label": "BESS Fit", "score": 74, "weight": 12, "contribution": 8.88}, {"key": "codFit", "label": "COD Fit", "score": 16, "weight": 8, "contribution": 1.28}, {"key": "tariffFit", "label": "Tariff Fit", "score": 100, "weight": 8, "contribution": 8}, {"key": "financialFit", "label": "Financial Feasibility", "score": 57.6, "weight": 10, "contribution": 5.76}, {"key": "technicalFit", "label": "Technical Feasibility", "score": 80, "weight": 10, "contribution": 8}, {"key": "connectivityFit", "label": "Connectivity Fit", "score": 54.4, "weight": 7, "contribution": 3.81}, {"key": "regulatoryFit", "label": "Regulatory Fit", "score": 80, "weight": 5, "contribution": 4}]	COMPLETE	t	2026-10-13 15:15:14.331
\.


--
-- Data for Name: IPPTariffComponent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPTariffComponent" (id, "modelId", key, label, amount, "capexLinked", "debtLinked", "bessLinked", "fixedRecovery", "sortOrder") FROM stdin;
cmv6tohac05l5mk3o24l9r53a	cmv6rs5pl0044146g5n60w0id	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6tohac05l6mk3o2ljre2tx	cmv6rs5pl0044146g5n60w0id	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6tohac05l7mk3okhahgt6x	cmv6rs5pl0044146g5n60w0id	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6tohac05l8mk3oubax52er	cmv6rs5pl0044146g5n60w0id	om	O&M	0.32	f	f	f	f	4
cmv6tohac05l9mk3ojoknwbxy	cmv6rs5pl0044146g5n60w0id	insurance	Insurance	0.07	f	f	f	f	5
cmv6tohac05lamk3okzchxwdp	cmv6rs5pl0044146g5n60w0id	land	Land	0.09	f	f	f	f	6
cmv6tohac05lbmk3ohc83b29g	cmv6rs5pl0044146g5n60w0id	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6tohac05lcmk3o3z12bpz3	cmv6rs5pl0044146g5n60w0id	bess	BESS	0	f	f	t	f	8
cmv6tohac05ldmk3oj9wqim5w	cmv6rs5pl0044146g5n60w0id	replacement	Replacement	0	f	f	t	f	9
cmv6tohac05lemk3o0se0jrmn	cmv6rs5pl0044146g5n60w0id	augmentation	Augmentation	0	f	f	t	f	10
cmv6tohac05lfmk3oc2ju6mhe	cmv6rs5pl0044146g5n60w0id	degradation	Degradation	0.08	f	f	f	f	11
cmv6tohac05lgmk3oa5g4az2t	cmv6rs5pl0044146g5n60w0id	development	Development	0.06	f	f	f	f	12
cmv6tohac05lhmk3olmmgdhsc	cmv6rs5pl0044146g5n60w0id	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6tohac05limk3optwwyvk7	cmv6rs5pl0044146g5n60w0id	contingency	Contingency	0.07	f	f	f	f	14
cmv6tohac05ljmk3opml61p6v	cmv6rs5pl0044146g5n60w0id	returns	Returns	0	f	f	f	f	15
cmv6tohgn05n5mk3obmg6negr	cmv6rs62h006m146gj31hzpwh	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6tohgn05n6mk3owup1wdse	cmv6rs62h006m146gj31hzpwh	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6tohgn05n7mk3oqsx51tig	cmv6rs62h006m146gj31hzpwh	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6tohgn05n8mk3otqy0q2wa	cmv6rs62h006m146gj31hzpwh	om	O&M	0.32	f	f	f	f	4
cmv6tohgn05n9mk3oib2z9ooq	cmv6rs62h006m146gj31hzpwh	insurance	Insurance	0.07	f	f	f	f	5
cmv6tohgn05namk3ofoi0v0xa	cmv6rs62h006m146gj31hzpwh	land	Land	0.09	f	f	f	f	6
cmv6tohgn05nbmk3oudhy9cqd	cmv6rs62h006m146gj31hzpwh	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6tohgn05ncmk3o5qxgiohc	cmv6rs62h006m146gj31hzpwh	bess	BESS	0	f	f	t	f	8
cmv6tohgn05ndmk3orajlx056	cmv6rs62h006m146gj31hzpwh	replacement	Replacement	0	f	f	t	f	9
cmv6tohgn05nemk3o3fe8fb7r	cmv6rs62h006m146gj31hzpwh	augmentation	Augmentation	0	f	f	t	f	10
cmv6tohgn05nfmk3o86ntghgx	cmv6rs62h006m146gj31hzpwh	degradation	Degradation	0.08	f	f	f	f	11
cmv6tohgn05ngmk3ofif8ni8f	cmv6rs62h006m146gj31hzpwh	development	Development	0.06	f	f	f	f	12
cmv6tohgn05nhmk3ol00gf1gc	cmv6rs62h006m146gj31hzpwh	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6tohgn05nimk3oxoowfrba	cmv6rs62h006m146gj31hzpwh	contingency	Contingency	0.07	f	f	f	f	14
cmv6tohgn05njmk3oyt8kh8ya	cmv6rs62h006m146gj31hzpwh	returns	Returns	0	f	f	f	f	15
cmv6tohm005p5mk3o5br2yjsh	cmv6rs66o007g146grchokppa	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6tohm005p6mk3op0ngziqo	cmv6rs66o007g146grchokppa	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6tohm005p7mk3o4cxitqpj	cmv6rs66o007g146grchokppa	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6tohm005p8mk3opnmnwqn8	cmv6rs66o007g146grchokppa	om	O&M	0.32	f	f	f	f	4
cmv6tohm005p9mk3on5vfckov	cmv6rs66o007g146grchokppa	insurance	Insurance	0.07	f	f	f	f	5
cmv6tohm005pamk3oo0b7he00	cmv6rs66o007g146grchokppa	land	Land	0.09	f	f	f	f	6
cmv6tohm005pbmk3oejhq9ahi	cmv6rs66o007g146grchokppa	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6tohm005pcmk3o4cueofw9	cmv6rs66o007g146grchokppa	bess	BESS	0	f	f	t	f	8
cmv6tohm005pdmk3oxgxcu0bi	cmv6rs66o007g146grchokppa	replacement	Replacement	0	f	f	t	f	9
cmv6tohm005pemk3oc4t4sfs3	cmv6rs66o007g146grchokppa	augmentation	Augmentation	0	f	f	t	f	10
cmv6tohm005pfmk3okga90url	cmv6rs66o007g146grchokppa	degradation	Degradation	0.08	f	f	f	f	11
cmv6tohm005pgmk3ociaj91gs	cmv6rs66o007g146grchokppa	development	Development	0.06	f	f	f	f	12
cmv6tohm005phmk3oq4otmp46	cmv6rs66o007g146grchokppa	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6tohm005pimk3ow3j41cyw	cmv6rs66o007g146grchokppa	contingency	Contingency	0.07	f	f	f	f	14
cmv6tohm005pjmk3omifdmwv5	cmv6rs66o007g146grchokppa	returns	Returns	0	f	f	f	f	15
cmv6tohrt05r5mk3obxxrpmpl	cmv6rs5ln003a146g2h4xiiwa	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6tohrt05r6mk3o0btvrq1b	cmv6rs5ln003a146g2h4xiiwa	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6tohrt05r7mk3omugr0559	cmv6rs5ln003a146g2h4xiiwa	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6tohrt05r8mk3o9pwrjoxa	cmv6rs5ln003a146g2h4xiiwa	om	O&M	0.32	f	f	f	f	4
cmv6tohrt05r9mk3o7w9w0o5j	cmv6rs5ln003a146g2h4xiiwa	insurance	Insurance	0.07	f	f	f	f	5
cmv6tohrt05ramk3o6etk4vn2	cmv6rs5ln003a146g2h4xiiwa	land	Land	0.09	f	f	f	f	6
cmv6tohrt05rbmk3oc2w0nwme	cmv6rs5ln003a146g2h4xiiwa	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6tohrt05rcmk3o1tx70hjc	cmv6rs5ln003a146g2h4xiiwa	bess	BESS	0	f	f	t	f	8
cmv6tohrt05rdmk3of9tycuz2	cmv6rs5ln003a146g2h4xiiwa	replacement	Replacement	0	f	f	t	f	9
cmv6tohrt05remk3o11ue30cf	cmv6rs5ln003a146g2h4xiiwa	augmentation	Augmentation	0	f	f	t	f	10
cmv6tohrt05rfmk3ogup7f2km	cmv6rs5ln003a146g2h4xiiwa	degradation	Degradation	0.08	f	f	f	f	11
cmv6tohrt05rgmk3o2ibtazf4	cmv6rs5ln003a146g2h4xiiwa	development	Development	0.06	f	f	f	f	12
cmv6tohrt05rhmk3oaqtpyrzs	cmv6rs5ln003a146g2h4xiiwa	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6tohrt05rimk3o0rgiho7o	cmv6rs5ln003a146g2h4xiiwa	contingency	Contingency	0.07	f	f	f	f	14
cmv6tohrt05rjmk3ofge695n0	cmv6rs5ln003a146g2h4xiiwa	returns	Returns	0	f	f	f	f	15
cmv6tohxc05t5mk3oljbbue6j	cmv6rs6iy009y146gwqd6ubxx	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6tohxc05t6mk3o41okk5c5	cmv6rs6iy009y146gwqd6ubxx	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6tohxc05t7mk3ogzawnlwc	cmv6rs6iy009y146gwqd6ubxx	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6tohxc05t8mk3onffu67i9	cmv6rs6iy009y146gwqd6ubxx	om	O&M	0.32	f	f	f	f	4
cmv6tohxc05t9mk3osfkxxnmt	cmv6rs6iy009y146gwqd6ubxx	insurance	Insurance	0.07	f	f	f	f	5
cmv6tohxc05tamk3o93wezxw0	cmv6rs6iy009y146gwqd6ubxx	land	Land	0.09	f	f	f	f	6
cmv6tohxc05tbmk3oa3jki5zq	cmv6rs6iy009y146gwqd6ubxx	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6tohxc05tcmk3oshx98mld	cmv6rs6iy009y146gwqd6ubxx	bess	BESS	0	f	f	t	f	8
cmv6tohxc05tdmk3o90f2ft70	cmv6rs6iy009y146gwqd6ubxx	replacement	Replacement	0	f	f	t	f	9
cmv6tohxc05temk3o8octt3mn	cmv6rs6iy009y146gwqd6ubxx	augmentation	Augmentation	0	f	f	t	f	10
cmv6tohxc05tfmk3o80r6cwvz	cmv6rs6iy009y146gwqd6ubxx	degradation	Degradation	0.08	f	f	f	f	11
cmv6tohxc05tgmk3oozh76y92	cmv6rs6iy009y146gwqd6ubxx	development	Development	0.06	f	f	f	f	12
cmv6tohxc05thmk3ofy89tjee	cmv6rs6iy009y146gwqd6ubxx	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6tohxc05timk3ooee9d6hg	cmv6rs6iy009y146gwqd6ubxx	contingency	Contingency	0.07	f	f	f	f	14
cmv6tohxc05tjmk3orjh9qan6	cmv6rs6iy009y146gwqd6ubxx	returns	Returns	0	f	f	f	f	15
cmv6toi7f05x5mk3o1mz3jgaa	cmv6rs5bw001m146gbrze4l3x	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6toi7f05x6mk3olo9ctpgv	cmv6rs5bw001m146gbrze4l3x	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6toi7f05x7mk3obn52wr1m	cmv6rs5bw001m146gbrze4l3x	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6toi7f05x8mk3oa4ucf4d5	cmv6rs5bw001m146gbrze4l3x	om	O&M	0.32	f	f	f	f	4
cmv6toi7f05x9mk3oqlja1909	cmv6rs5bw001m146gbrze4l3x	insurance	Insurance	0.07	f	f	f	f	5
cmv6toi7f05xamk3otjbht9nb	cmv6rs5bw001m146gbrze4l3x	land	Land	0.09	f	f	f	f	6
cmv6toi7f05xbmk3oml2meccd	cmv6rs5bw001m146gbrze4l3x	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6toi7f05xcmk3ot2srbgr6	cmv6rs5bw001m146gbrze4l3x	bess	BESS	0	f	f	t	f	8
cmv6toi7f05xdmk3okwnfr2ze	cmv6rs5bw001m146gbrze4l3x	replacement	Replacement	0	f	f	t	f	9
cmv6toi7f05xemk3oi60e8l1j	cmv6rs5bw001m146gbrze4l3x	augmentation	Augmentation	0	f	f	t	f	10
cmv6toi7f05xfmk3oih4xk65u	cmv6rs5bw001m146gbrze4l3x	degradation	Degradation	0.08	f	f	f	f	11
cmv6toi7f05xgmk3ozyixdakz	cmv6rs5bw001m146gbrze4l3x	development	Development	0.06	f	f	f	f	12
cmv6toi7f05xhmk3oxo0lqqv4	cmv6rs5bw001m146gbrze4l3x	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6toi7f05ximk3oacsy0fyl	cmv6rs5bw001m146gbrze4l3x	contingency	Contingency	0.07	f	f	f	f	14
cmv6toi7f05xjmk3oqsvnc1rc	cmv6rs5bw001m146gbrze4l3x	returns	Returns	0	f	f	f	f	15
cmv6toii60615mk3ojgybgyjf	cmv6rs73r00e4146gug8ebqws	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6toii60616mk3oenrpzqe1	cmv6rs73r00e4146gug8ebqws	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6toii60617mk3otfuirg9s	cmv6rs73r00e4146gug8ebqws	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6toii60618mk3oea2z8qp6	cmv6rs73r00e4146gug8ebqws	om	O&M	0.32	f	f	f	f	4
cmv6toii60619mk3oczq8occj	cmv6rs73r00e4146gug8ebqws	insurance	Insurance	0.07	f	f	f	f	5
cmv6toii6061amk3o38xubqj9	cmv6rs73r00e4146gug8ebqws	land	Land	0.09	f	f	f	f	6
cmv6toii6061bmk3ot7dwimzk	cmv6rs73r00e4146gug8ebqws	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6toii6061cmk3ot1u0ojmy	cmv6rs73r00e4146gug8ebqws	bess	BESS	0	f	f	t	f	8
cmv6toii6061dmk3od62dh23h	cmv6rs73r00e4146gug8ebqws	replacement	Replacement	0	f	f	t	f	9
cmv6toii6061emk3o7p5me3bp	cmv6rs73r00e4146gug8ebqws	augmentation	Augmentation	0	f	f	t	f	10
cmv6toii6061fmk3o5yc3o161	cmv6rs73r00e4146gug8ebqws	degradation	Degradation	0.08	f	f	f	f	11
cmv6toii6061gmk3oh0lkfj5p	cmv6rs73r00e4146gug8ebqws	development	Development	0.06	f	f	f	f	12
cmv6toii6061hmk3ouo5dvtba	cmv6rs73r00e4146gug8ebqws	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6toii6061imk3oiswrof8i	cmv6rs73r00e4146gug8ebqws	contingency	Contingency	0.07	f	f	f	f	14
cmv6toii6061jmk3opcem56d7	cmv6rs73r00e4146gug8ebqws	returns	Returns	0	f	f	f	f	15
cmv6toiyx0655mk3ods3mropc	cmv6rs6qz00bm146go4zjisky	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6toiyx0656mk3oe1pguh56	cmv6rs6qz00bm146go4zjisky	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6toiyx0657mk3o8uv2qumh	cmv6rs6qz00bm146go4zjisky	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6toiyy0658mk3octy77nz3	cmv6rs6qz00bm146go4zjisky	om	O&M	0.32	f	f	f	f	4
cmv6toiyy0659mk3owolf1bm3	cmv6rs6qz00bm146go4zjisky	insurance	Insurance	0.07	f	f	f	f	5
cmv6toiyy065amk3ozjuyk9gn	cmv6rs6qz00bm146go4zjisky	land	Land	0.09	f	f	f	f	6
cmv6toiyy065bmk3oiag5zahz	cmv6rs6qz00bm146go4zjisky	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6toiyy065cmk3oy2tyx12v	cmv6rs6qz00bm146go4zjisky	bess	BESS	0	f	f	t	f	8
cmv6toiyy065dmk3ojd979nvy	cmv6rs6qz00bm146go4zjisky	replacement	Replacement	0	f	f	t	f	9
cmv6toiyy065emk3on1n7f53q	cmv6rs6qz00bm146go4zjisky	augmentation	Augmentation	0	f	f	t	f	10
cmv6toiyy065fmk3o4j8gv0uu	cmv6rs6qz00bm146go4zjisky	degradation	Degradation	0.08	f	f	f	f	11
cmv6toiyy065gmk3ogvn4f0bf	cmv6rs6qz00bm146go4zjisky	development	Development	0.06	f	f	f	f	12
cmv6toiyy065hmk3ohgtx8sju	cmv6rs6qz00bm146go4zjisky	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6toiyy065imk3oraysvagr	cmv6rs6qz00bm146go4zjisky	contingency	Contingency	0.07	f	f	f	f	14
cmv6toiyy065jmk3o5tbrrsd5	cmv6rs6qz00bm146go4zjisky	returns	Returns	0	f	f	f	f	15
cmv6toj9g0695mk3odmrs41oo	cmv6rs54i000s146gc0743sxm	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6toj9g0696mk3op2htyo1z	cmv6rs54i000s146gc0743sxm	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6toj9g0697mk3opdaujzjv	cmv6rs54i000s146gc0743sxm	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6toj9g0698mk3oa9cemefs	cmv6rs54i000s146gc0743sxm	om	O&M	0.32	f	f	f	f	4
cmv6toj9g0699mk3oylklx0ak	cmv6rs54i000s146gc0743sxm	insurance	Insurance	0.07	f	f	f	f	5
cmv6toj9g069amk3oqmj8l6ii	cmv6rs54i000s146gc0743sxm	land	Land	0.09	f	f	f	f	6
cmv6toj9g069bmk3obxk2a40l	cmv6rs54i000s146gc0743sxm	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6toj9g069cmk3ok2dcfgj8	cmv6rs54i000s146gc0743sxm	bess	BESS	0	f	f	t	f	8
cmv6toj9g069dmk3ow9igdsm2	cmv6rs54i000s146gc0743sxm	replacement	Replacement	0	f	f	t	f	9
cmv6toj9g069emk3oidm1rkef	cmv6rs54i000s146gc0743sxm	augmentation	Augmentation	0	f	f	t	f	10
cmv6toj9g069fmk3ow4anb7nm	cmv6rs54i000s146gc0743sxm	degradation	Degradation	0.08	f	f	f	f	11
cmv6toj9g069gmk3ox4aeufzp	cmv6rs54i000s146gc0743sxm	development	Development	0.06	f	f	f	f	12
cmv6toj9g069hmk3ox08btife	cmv6rs54i000s146gc0743sxm	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6toj9g069imk3ov6xidy92	cmv6rs54i000s146gc0743sxm	contingency	Contingency	0.07	f	f	f	f	14
cmv6toj9g069jmk3owbzbc23o	cmv6rs54i000s146gc0743sxm	returns	Returns	0	f	f	f	f	15
cmv6tojj906d5mk3onv59sw6f	cmv6rs5tu004y146g7ocb71ni	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6tojj906d6mk3o9sky57p3	cmv6rs5tu004y146g7ocb71ni	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6tojj906d7mk3onszl7tpe	cmv6rs5tu004y146g7ocb71ni	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6tojj906d8mk3ot7wh8v1v	cmv6rs5tu004y146g7ocb71ni	om	O&M	0.32	f	f	f	f	4
cmv6tojj906d9mk3offud8atl	cmv6rs5tu004y146g7ocb71ni	insurance	Insurance	0.07	f	f	f	f	5
cmv6tojj906damk3o7a18nb91	cmv6rs5tu004y146g7ocb71ni	land	Land	0.09	f	f	f	f	6
cmv6toi2805v5mk3opxf5hho6	cmv6rs6mt00as146g57yprmb2	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6toi2805v6mk3o0t9hz6be	cmv6rs6mt00as146g57yprmb2	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6toi2805v7mk3ohdsyfhl2	cmv6rs6mt00as146g57yprmb2	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6toi2805v8mk3ozjb7piru	cmv6rs6mt00as146g57yprmb2	om	O&M	0.32	f	f	f	f	4
cmv6toi2905v9mk3owwh1b86h	cmv6rs6mt00as146g57yprmb2	insurance	Insurance	0.07	f	f	f	f	5
cmv6toi2905vamk3opgruhc87	cmv6rs6mt00as146g57yprmb2	land	Land	0.09	f	f	f	f	6
cmv6toi2905vbmk3olnfnx8ne	cmv6rs6mt00as146g57yprmb2	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6toi2905vcmk3oaoy5ymfx	cmv6rs6mt00as146g57yprmb2	bess	BESS	0	f	f	t	f	8
cmv6toi2905vdmk3o4bncn4h6	cmv6rs6mt00as146g57yprmb2	replacement	Replacement	0	f	f	t	f	9
cmv6toi2905vemk3orf3kr9hs	cmv6rs6mt00as146g57yprmb2	augmentation	Augmentation	0	f	f	t	f	10
cmv6toi2905vfmk3offbiqd7y	cmv6rs6mt00as146g57yprmb2	degradation	Degradation	0.08	f	f	f	f	11
cmv6toi2905vgmk3ofik99g1d	cmv6rs6mt00as146g57yprmb2	development	Development	0.06	f	f	f	f	12
cmv6toi2905vhmk3oxk243j4n	cmv6rs6mt00as146g57yprmb2	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6toi2905vimk3ohco1tr8h	cmv6rs6mt00as146g57yprmb2	contingency	Contingency	0.07	f	f	f	f	14
cmv6toi2905vjmk3oj70b89m5	cmv6rs6mt00as146g57yprmb2	returns	Returns	0	f	f	f	f	15
cmv6toid305z5mk3ooxgmalex	cmv6rs5gv002g146gksr2nnyv	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6toid305z6mk3o926pcu39	cmv6rs5gv002g146gksr2nnyv	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6toid305z7mk3oysyqnjqd	cmv6rs5gv002g146gksr2nnyv	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6toid305z8mk3ovhe6i9f2	cmv6rs5gv002g146gksr2nnyv	om	O&M	0.32	f	f	f	f	4
cmv6toid305z9mk3o4ognk6qr	cmv6rs5gv002g146gksr2nnyv	insurance	Insurance	0.07	f	f	f	f	5
cmv6toid305zamk3oqs82mpf2	cmv6rs5gv002g146gksr2nnyv	land	Land	0.09	f	f	f	f	6
cmv6toid305zbmk3ogu9cxkwr	cmv6rs5gv002g146gksr2nnyv	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6toid305zcmk3otg08sav7	cmv6rs5gv002g146gksr2nnyv	bess	BESS	0	f	f	t	f	8
cmv6toid305zdmk3obs7iwbr1	cmv6rs5gv002g146gksr2nnyv	replacement	Replacement	0	f	f	t	f	9
cmv6toid305zemk3ovfxmsok3	cmv6rs5gv002g146gksr2nnyv	augmentation	Augmentation	0	f	f	t	f	10
cmv6toid405zfmk3odnqpm9fi	cmv6rs5gv002g146gksr2nnyv	degradation	Degradation	0.08	f	f	f	f	11
cmv6toid405zgmk3oymd38i1a	cmv6rs5gv002g146gksr2nnyv	development	Development	0.06	f	f	f	f	12
cmv6toid405zhmk3op86wulph	cmv6rs5gv002g146gksr2nnyv	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6toid405zimk3orbyhs50w	cmv6rs5gv002g146gksr2nnyv	contingency	Contingency	0.07	f	f	f	f	14
cmv6toid405zjmk3obi3qczdb	cmv6rs5gv002g146gksr2nnyv	returns	Returns	0	f	f	f	f	15
cmv6toisk0635mk3oxwq1rjpg	cmv6rs6vj00cg146grl0mp49a	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6toisk0636mk3o2pcwcqw0	cmv6rs6vj00cg146grl0mp49a	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6toisk0637mk3o434qgkug	cmv6rs6vj00cg146grl0mp49a	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6toisk0638mk3ojnocrdgd	cmv6rs6vj00cg146grl0mp49a	om	O&M	0.32	f	f	f	f	4
cmv6toisk0639mk3obhkcjrjn	cmv6rs6vj00cg146grl0mp49a	insurance	Insurance	0.07	f	f	f	f	5
cmv6toisk063amk3ollyj8cuj	cmv6rs6vj00cg146grl0mp49a	land	Land	0.09	f	f	f	f	6
cmv6toisk063bmk3ohr2e267o	cmv6rs6vj00cg146grl0mp49a	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6toisk063cmk3o7a7xnr7e	cmv6rs6vj00cg146grl0mp49a	bess	BESS	0	f	f	t	f	8
cmv6toisl063dmk3o7lmgei2a	cmv6rs6vj00cg146grl0mp49a	replacement	Replacement	0	f	f	t	f	9
cmv6toisl063emk3ofd6395b5	cmv6rs6vj00cg146grl0mp49a	augmentation	Augmentation	0	f	f	t	f	10
cmv6toisl063fmk3o22a14rqf	cmv6rs6vj00cg146grl0mp49a	degradation	Degradation	0.08	f	f	f	f	11
cmv6toisl063gmk3omo3y0ym1	cmv6rs6vj00cg146grl0mp49a	development	Development	0.06	f	f	f	f	12
cmv6toisl063hmk3owa4c6a4n	cmv6rs6vj00cg146grl0mp49a	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6toisl063imk3os52y6n5i	cmv6rs6vj00cg146grl0mp49a	contingency	Contingency	0.07	f	f	f	f	14
cmv6toisl063jmk3ot4yjsl9v	cmv6rs6vj00cg146grl0mp49a	returns	Returns	0	f	f	f	f	15
cmv6toj490675mk3oe9egd363	cmv6rs6en0094146gfrgr5j96	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6toj490676mk3oeospi524	cmv6rs6en0094146gfrgr5j96	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6toj490677mk3o96c5nwuy	cmv6rs6en0094146gfrgr5j96	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6toj490678mk3o20rrscrv	cmv6rs6en0094146gfrgr5j96	om	O&M	0.32	f	f	f	f	4
cmv6toj490679mk3o6ov5qwfs	cmv6rs6en0094146gfrgr5j96	insurance	Insurance	0.07	f	f	f	f	5
cmv6toj49067amk3o4j9levy1	cmv6rs6en0094146gfrgr5j96	land	Land	0.09	f	f	f	f	6
cmv6toj49067bmk3oc9zzq9gq	cmv6rs6en0094146gfrgr5j96	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6toj49067cmk3of82bzhsw	cmv6rs6en0094146gfrgr5j96	bess	BESS	0	f	f	t	f	8
cmv6toj49067dmk3ou4h284dh	cmv6rs6en0094146gfrgr5j96	replacement	Replacement	0	f	f	t	f	9
cmv6toj49067emk3osk14t591	cmv6rs6en0094146gfrgr5j96	augmentation	Augmentation	0	f	f	t	f	10
cmv6toj49067fmk3obckoofb8	cmv6rs6en0094146gfrgr5j96	degradation	Degradation	0.08	f	f	f	f	11
cmv6toj49067gmk3obxw16na9	cmv6rs6en0094146gfrgr5j96	development	Development	0.06	f	f	f	f	12
cmv6toj49067hmk3oztitzw9x	cmv6rs6en0094146gfrgr5j96	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6toj49067imk3ov4u5wj5j	cmv6rs6en0094146gfrgr5j96	contingency	Contingency	0.07	f	f	f	f	14
cmv6toj49067jmk3odohkw7se	cmv6rs6en0094146gfrgr5j96	returns	Returns	0	f	f	f	f	15
cmv6toje606b5mk3ovyqtu4gm	cmv6rs6ap008a146g7a3htfe8	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6toje606b6mk3oqeum2otx	cmv6rs6ap008a146g7a3htfe8	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6toje606b7mk3ob7mgsx7y	cmv6rs6ap008a146g7a3htfe8	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6toje606b8mk3oremya6u6	cmv6rs6ap008a146g7a3htfe8	om	O&M	0.32	f	f	f	f	4
cmv6toje606b9mk3oqcn0cks2	cmv6rs6ap008a146g7a3htfe8	insurance	Insurance	0.07	f	f	f	f	5
cmv6toje606bamk3ozkkistaj	cmv6rs6ap008a146g7a3htfe8	land	Land	0.09	f	f	f	f	6
cmv6toje606bbmk3obtzp1efz	cmv6rs6ap008a146g7a3htfe8	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6toje606bcmk3oe7ekfqi7	cmv6rs6ap008a146g7a3htfe8	bess	BESS	0	f	f	t	f	8
cmv6toje606bdmk3os03xmf47	cmv6rs6ap008a146g7a3htfe8	replacement	Replacement	0	f	f	t	f	9
cmv6toje606bemk3oj41o36pj	cmv6rs6ap008a146g7a3htfe8	augmentation	Augmentation	0	f	f	t	f	10
cmv6toje606bfmk3o2cag8nep	cmv6rs6ap008a146g7a3htfe8	degradation	Degradation	0.08	f	f	f	f	11
cmv6toje606bgmk3oo7la3tcr	cmv6rs6ap008a146g7a3htfe8	development	Development	0.06	f	f	f	f	12
cmv6toje606bhmk3oopbi5fm0	cmv6rs6ap008a146g7a3htfe8	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6toje606bimk3olbk0q7yn	cmv6rs6ap008a146g7a3htfe8	contingency	Contingency	0.07	f	f	f	f	14
cmv6toje606bjmk3onl6dym5d	cmv6rs6ap008a146g7a3htfe8	returns	Returns	0	f	f	f	f	15
cmv6tojo806f5mk3o9cce53kt	cmv6rs7ct00fs146g95k0uuqc	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6tojo806f6mk3onwg99zin	cmv6rs7ct00fs146g95k0uuqc	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6tojo806f7mk3oaf0jyu9q	cmv6rs7ct00fs146g95k0uuqc	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6tojo806f8mk3ofinmnvj5	cmv6rs7ct00fs146g95k0uuqc	om	O&M	0.32	f	f	f	f	4
cmv6tojo806f9mk3ob6o930ww	cmv6rs7ct00fs146g95k0uuqc	insurance	Insurance	0.07	f	f	f	f	5
cmv6tojo806famk3o8ctadb8b	cmv6rs7ct00fs146g95k0uuqc	land	Land	0.09	f	f	f	f	6
cmv6tojo806fbmk3o4lmpbm2g	cmv6rs7ct00fs146g95k0uuqc	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6tojo806fcmk3oabf6wf6x	cmv6rs7ct00fs146g95k0uuqc	bess	BESS	0	f	f	t	f	8
cmv6tojo806fdmk3or98ncd3w	cmv6rs7ct00fs146g95k0uuqc	replacement	Replacement	0	f	f	t	f	9
cmv6tojo806femk3omru6ce39	cmv6rs7ct00fs146g95k0uuqc	augmentation	Augmentation	0	f	f	t	f	10
cmv6tojo806ffmk3ov6hwryp0	cmv6rs7ct00fs146g95k0uuqc	degradation	Degradation	0.08	f	f	f	f	11
cmv6tojo806fgmk3otzwlgxgx	cmv6rs7ct00fs146g95k0uuqc	development	Development	0.06	f	f	f	f	12
cmv6tojo806fhmk3ogg9igzir	cmv6rs7ct00fs146g95k0uuqc	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6tojo806fimk3ofni2da7c	cmv6rs7ct00fs146g95k0uuqc	contingency	Contingency	0.07	f	f	f	f	14
cmv6tojo806fjmk3oumg2mldt	cmv6rs7ct00fs146g95k0uuqc	returns	Returns	0	f	f	f	f	15
cmv6tok7s06n4mk3ofipeki1r	cmv6rs78j00ey146g85xsy9b2	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6tok7s06n5mk3orqozdsko	cmv6rs78j00ey146g85xsy9b2	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6tok7s06n6mk3oavprmo8f	cmv6rs78j00ey146g85xsy9b2	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6tok7s06n7mk3o65fa0noj	cmv6rs78j00ey146g85xsy9b2	om	O&M	0.32	f	f	f	f	4
cmv6tok7s06n8mk3oboynczii	cmv6rs78j00ey146g85xsy9b2	insurance	Insurance	0.07	f	f	f	f	5
cmv6tok7s06n9mk3oll6fis0n	cmv6rs78j00ey146g85xsy9b2	land	Land	0.09	f	f	f	f	6
cmv6tok7s06namk3o3mc28hb4	cmv6rs78j00ey146g85xsy9b2	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6tok7s06nbmk3oainj4yqi	cmv6rs78j00ey146g85xsy9b2	bess	BESS	0	f	f	t	f	8
cmv6tok7s06ncmk3ojxqvmw0z	cmv6rs78j00ey146g85xsy9b2	replacement	Replacement	0	f	f	t	f	9
cmv6tok7s06ndmk3o7fr3cypg	cmv6rs78j00ey146g85xsy9b2	augmentation	Augmentation	0	f	f	t	f	10
cmv6tok7s06nemk3o7lwr9jpb	cmv6rs78j00ey146g85xsy9b2	degradation	Degradation	0.08	f	f	f	f	11
cmv6tok7s06nfmk3odkseddkc	cmv6rs78j00ey146g85xsy9b2	development	Development	0.06	f	f	f	f	12
cmv6tok7s06ngmk3or2atngv8	cmv6rs78j00ey146g85xsy9b2	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6tok7s06nhmk3o16njzw91	cmv6rs78j00ey146g85xsy9b2	contingency	Contingency	0.07	f	f	f	f	14
cmv6tok7s06nimk3oa1n40rgn	cmv6rs78j00ey146g85xsy9b2	returns	Returns	0	f	f	f	f	15
cmv6tojj906dbmk3ors3kq0gk	cmv6rs5tu004y146g7ocb71ni	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6tojj906dcmk3o1aiys0ki	cmv6rs5tu004y146g7ocb71ni	bess	BESS	0	f	f	t	f	8
cmv6tojj906ddmk3o6vc5gnx2	cmv6rs5tu004y146g7ocb71ni	replacement	Replacement	0	f	f	t	f	9
cmv6tojj906demk3od3g722su	cmv6rs5tu004y146g7ocb71ni	augmentation	Augmentation	0	f	f	t	f	10
cmv6tojj906dfmk3oxlf9b8ua	cmv6rs5tu004y146g7ocb71ni	degradation	Degradation	0.08	f	f	f	f	11
cmv6tojj906dgmk3ojp45gmeu	cmv6rs5tu004y146g7ocb71ni	development	Development	0.06	f	f	f	f	12
cmv6tojj906dhmk3o7uhz8wqn	cmv6rs5tu004y146g7ocb71ni	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6tojj906dimk3oeuqoi3uh	cmv6rs5tu004y146g7ocb71ni	contingency	Contingency	0.07	f	f	f	f	14
cmv6tojj906djmk3ojtw7cp1v	cmv6rs5tu004y146g7ocb71ni	returns	Returns	0	f	f	f	f	15
cmv6tojth06h5mk3o1qr1arij	cmv6rs6zi00da146gwh9dhudj	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6tojth06h6mk3o95x9twvh	cmv6rs6zi00da146gwh9dhudj	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6tojth06h7mk3omzss2c48	cmv6rs6zi00da146gwh9dhudj	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6tojth06h8mk3o9614aa1f	cmv6rs6zi00da146gwh9dhudj	om	O&M	0.32	f	f	f	f	4
cmv6tojth06h9mk3oszglk1uy	cmv6rs6zi00da146gwh9dhudj	insurance	Insurance	0.07	f	f	f	f	5
cmv6tojth06hamk3oawigds8s	cmv6rs6zi00da146gwh9dhudj	land	Land	0.09	f	f	f	f	6
cmv6tojth06hbmk3ondobwp73	cmv6rs6zi00da146gwh9dhudj	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6tojth06hcmk3oxln6boh4	cmv6rs6zi00da146gwh9dhudj	bess	BESS	0	f	f	t	f	8
cmv6tojth06hdmk3oxrcjeazh	cmv6rs6zi00da146gwh9dhudj	replacement	Replacement	0	f	f	t	f	9
cmv6tojth06hemk3oha2vyowm	cmv6rs6zi00da146gwh9dhudj	augmentation	Augmentation	0	f	f	t	f	10
cmv6tojth06hfmk3o9rt4ptm0	cmv6rs6zi00da146gwh9dhudj	degradation	Degradation	0.08	f	f	f	f	11
cmv6tojth06hgmk3oy7h88txo	cmv6rs6zi00da146gwh9dhudj	development	Development	0.06	f	f	f	f	12
cmv6tojth06hhmk3oxzpy2jff	cmv6rs6zi00da146gwh9dhudj	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6tojth06himk3osesjs6zz	cmv6rs6zi00da146gwh9dhudj	contingency	Contingency	0.07	f	f	f	f	14
cmv6tojth06hjmk3omej5im64	cmv6rs6zi00da146gwh9dhudj	returns	Returns	0	f	f	f	f	15
cmv6tok3506l4mk3ogs5hm3mx	cmv6rs5y3005s146ghjuxoqd1	capexRecovery	CAPEX Recovery	89.6657	t	f	f	t	1
cmv6tok3506l5mk3oq64852e1	cmv6rs5y3005s146ghjuxoqd1	debtServicing	Debt Servicing	69.74	t	t	f	t	2
cmv6tok3506l6mk3obkfj58aw	cmv6rs5y3005s146ghjuxoqd1	equityReturn	Equity Return	39.8514	t	f	f	t	3
cmv6tok3506l7mk3ovbfqy76s	cmv6rs5y3005s146ghjuxoqd1	om	O&M	0.32	f	f	f	f	4
cmv6tok3506l8mk3o4q3kfaaq	cmv6rs5y3005s146ghjuxoqd1	insurance	Insurance	0.07	f	f	f	f	5
cmv6tok3506l9mk3ocezs8ynf	cmv6rs5y3005s146ghjuxoqd1	land	Land	0.09	f	f	f	f	6
cmv6tok3506lamk3omp6663bt	cmv6rs5y3005s146ghjuxoqd1	evacuation	Evacuation	0.14	f	f	f	f	7
cmv6tok3506lbmk3ox1ylcad2	cmv6rs5y3005s146ghjuxoqd1	bess	BESS	0	f	f	t	f	8
cmv6tok3506lcmk3of4yoj8r6	cmv6rs5y3005s146ghjuxoqd1	replacement	Replacement	0	f	f	t	f	9
cmv6tok3506ldmk3o1v8lqdbs	cmv6rs5y3005s146ghjuxoqd1	augmentation	Augmentation	0	f	f	t	f	10
cmv6tok3606lemk3oooejcdy7	cmv6rs5y3005s146ghjuxoqd1	degradation	Degradation	0.08	f	f	f	f	11
cmv6tok3606lfmk3omqrh0qcg	cmv6rs5y3005s146ghjuxoqd1	development	Development	0.06	f	f	f	f	12
cmv6tok3606lgmk3ot85sy6bn	cmv6rs5y3005s146ghjuxoqd1	regulatoryRisk	Regulatory Risk	0.05	f	f	f	f	13
cmv6tok3606lhmk3odx2aeb4v	cmv6rs5y3005s146ghjuxoqd1	contingency	Contingency	0.07	f	f	f	f	14
cmv6tok3606limk3o9jmnpw4k	cmv6rs5y3005s146ghjuxoqd1	returns	Returns	0	f	f	f	f	15
\.


--
-- Data for Name: IPPTariffModel; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPTariffModel" (id, "ippId", unit, "quotedTariff", "calculatedTariff", sustainability, "escalationClear", "evacuationExcluded", "bessExcluded", drivers) FROM stdin;
cmv6rs5bw001m146gbrze4l3x	ipp_1791901322469	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
cmv6rs54i000s146gc0743sxm	ipp_1791901322213	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
cmv6rs62h006m146gj31hzpwh	ipp_1791901323443	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
cmv6rs66o007g146grchokppa	ipp_1791901323592	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
cmv6rs5ln003a146g2h4xiiwa	ipp_1791901322836	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
cmv6rs6iy009y146gwqd6ubxx	ipp_1791901324035	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
cmv6rs6mt00as146g57yprmb2	ipp_1791901324175	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
cmv6rs5gv002g146gksr2nnyv	ipp_1791901322663	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
cmv6rs6qz00bm146go4zjisky	ipp_1791901324322	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
cmv6rs6en0094146gfrgr5j96	ipp_1791901323881	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
cmv6rs6ap008a146g7a3htfe8	ipp_1791901323738	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
cmv6rs5tu004y146g7ocb71ni	ipp_1791901323132	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
cmv6rs5y3005s146ghjuxoqd1	ipp_1791901323285	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
cmv6rs5pl0044146g5n60w0id	ipp_1791901322977	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
cmv6rs73r00e4146gug8ebqws	ipp_1791901324785	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
cmv6rs6vj00cg146grl0mp49a	ipp_1791901324487	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
cmv6rs7ct00fs146g95k0uuqc	ipp_1791901325112	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
cmv6rs6zi00da146gwh9dhudj	ipp_1791901324632	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
cmv6rs78j00ey146g85xsy9b2	ipp_1791901324956	INR/kWh	1	200.1371	UNSUSTAINABLE	t	f	f	{"opex": {"om": 0.32, "bess": 0, "land": 0.09, "insurance": 0.07, "evacuation": 0.14, "regulatory": 0.05, "contingency": 0.07, "degradation": 0.08, "development": 0.06, "replacement": 0, "augmentation": 0}, "debtRatio": 0.7, "equityIrr": 0.135, "capexInrCr": 200, "interestRate": 0.09, "generationGwh": 1, "bessCapexInrCr": 0, "loanTenureYears": 18, "moratoriumYears": 0.5, "projectLifeYears": 25}
\.


--
-- Data for Name: IPPTariffScenario; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPTariffScenario" (id, "modelId", name, assumptions, "baseTariff", "scenarioTariff", change, "changePct", financial, "createdAt") FROM stdin;
\.


--
-- Data for Name: IPPTechnology; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPTechnology" (id, "ippId", solar, wind, bess, hybrid) FROM stdin;
cmv6rs54h0004146g9yj3bpyt	ipp_1791901322213	f	f	f	f
cmv6rs5bs000y146gmfz68jk6	ipp_1791901322469	f	f	f	f
cmv6rs5gu001s146g9s5bq0yk	ipp_1791901322663	f	f	f	f
cmv6rs5ll002m146gzud0l6y8	ipp_1791901322836	f	f	f	f
cmv6rs5pk003g146g0ppn9827	ipp_1791901322977	f	f	f	f
cmv6rs5tt004a146gh6ciox24	ipp_1791901323132	f	f	f	f
cmv6rs5y20054146gk4x2zhc4	ipp_1791901323285	f	f	f	f
cmv6rs62g005y146golj4voxk	ipp_1791901323443	f	f	f	f
cmv6rs66n006s146gf3v7betp	ipp_1791901323592	f	f	f	f
cmv6rs6an007m146gqpm7fbau	ipp_1791901323738	f	f	f	f
cmv6rs6em008g146g2larpdqj	ipp_1791901323881	f	f	f	f
cmv6rs6iw009a146gxxb0zx3r	ipp_1791901324035	f	f	f	f
cmv6rs6ms00a4146gz41w7vcu	ipp_1791901324175	f	f	f	f
cmv6rs6qy00ay146g6m5fysmj	ipp_1791901324322	f	f	f	f
cmv6rs6vh00bs146gdgalwkyq	ipp_1791901324487	f	f	f	f
cmv6rs6zg00cm146gsj39b6qj	ipp_1791901324632	f	f	f	f
cmv6rs73p00dg146gtk269h9z	ipp_1791901324785	f	f	f	f
cmv6rs78i00ea146gg4jywd2w	ipp_1791901324956	f	f	f	f
cmv6rs7cs00f4146gxavca0qy	ipp_1791901325112	f	f	f	f
\.


--
-- Data for Name: IPPWindProfile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."IPPWindProfile" (id, "ippId", "wtgRatingMw", "hubHeightM", "rotorDiameterM", "resourceMethodology", cuf, "wakeLoss", availability, evidences, "dataQuality") FROM stdin;
cmv6rs54h0006146g3zm1y2xf	ipp_1791901322213	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs5bs0010146g3fvfnmhp	ipp_1791901322469	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs5gu001u146ggo0voxln	ipp_1791901322663	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs5ll002o146gf6uwcu8n	ipp_1791901322836	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs5pk003i146gfp7sfrch	ipp_1791901322977	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs5tt004c146gc3harx9r	ipp_1791901323132	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs5y20056146gkkgvt371	ipp_1791901323285	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs62g0060146g8iynx8ge	ipp_1791901323443	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs66n006u146gszqq1yf9	ipp_1791901323592	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6an007o146gz316tbcu	ipp_1791901323738	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6em008i146gvu12ozb1	ipp_1791901323881	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6iw009c146gton402lc	ipp_1791901324035	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6ms00a6146gfj5heui2	ipp_1791901324175	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6qy00b0146gokvcfpca	ipp_1791901324322	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6vi00bu146gjnwtihyf	ipp_1791901324487	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs6zh00co146gqukjv3w4	ipp_1791901324632	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs73q00di146gv5xysfah	ipp_1791901324785	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs78i00ec146gvrqsc2pr	ipp_1791901324956	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
cmv6rs7cs00f6146gftl17fo3	ipp_1791901325112	0	0	0	Not applicable	0	0	0	[{"unit": "%", "field": "Wind CUF", "value": "0", "source": "Illustrative IPP submission", "status": "RECEIVED", "evidence": "Wind CUF sheet", "reviewedBy": "Technical reviewer", "uploadedAt": "2026-10-01"}]	MISSING
\.


--
-- Data for Name: LoadMatchResult; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."LoadMatchResult" (id, "gesId", "ippId", "requiredGwh", "availableGwh", "matchedGwh", "surplusGwh", "deficitGwh", "coveragePct", "loadMatchPct", series, "dataQuality", "calculatedAt") FROM stdin;
cmv6tohxz05tlmk3o3kr8g106	ges_1791904510208	ipp_1791901324035	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:11.364
cmv6toi7y05xlmk3o1nf58ukn	ges_1791904510208	ipp_1791901322469	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:11.731
cmv6tohb605llmk3ochz5z3wi	ges_1791904510208	ipp_1791901322977	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:10.496
cmv6tohml05plmk3o8c62ymlv	ges_1791904510208	ipp_1791901323592	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:10.949
cmv6tohhd05nlmk3owjbt2ido	ges_1791904510208	ipp_1791901323443	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:10.745
cmv6tohsj05rlmk3opzo08kph	ges_1791904510208	ipp_1791901322836	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:11.158
cmv6toi2s05vlmk3o36dr2pcl	ges_1791904510208	ipp_1791901324175	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:11.538
cmv6toidp05zlmk3ow3ohdscb	ges_1791904510208	ipp_1791901322663	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:11.925
cmv6toiiq061lmk3omjfzhtuy	ges_1791904510208	ipp_1791901324785	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:12.103
cmv6toits063lmk3o6jv2ytbs	ges_1791904510208	ipp_1791901324487	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:12.381
cmv6toizh065lmk3o6aq6fo6w	ges_1791904510208	ipp_1791901324322	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:12.72
cmv6toj4t067lmk3odik9iukt	ges_1791904510208	ipp_1791901323881	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:12.907
cmv6toj9x069lmk3o3japg8in	ges_1791904510208	ipp_1791901322213	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:13.101
cmv6tojjt06dlmk3oik9h61z6	ges_1791904510208	ipp_1791901323132	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:13.445
cmv6tojty06hlmk3oc2fq92w3	ges_1791904510208	ipp_1791901324632	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:13.82
cmv6tok3n06lkmk3ot2poq10u	ges_1791904510208	ipp_1791901323285	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:14.17
cmv6tojen06blmk3of6aacy7y	ges_1791904510208	ipp_1791901323738	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:13.269
cmv6tojot06flmk3os9oqk4g8	ges_1791904510208	ipp_1791901325112	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:13.629
cmv6tok8b06nkmk3o8ryeedjs	ges_1791904510208	ipp_1791901324956	0	0	0	0	0	0	0	[{"t": "00:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "00:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "01:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "02:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "03:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "04:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "05:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "06:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "07:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "08:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "09:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "10:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "11:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "12:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "13:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "14:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "15:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "16:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "17:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "18:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "19:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "20:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "21:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "22:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:00", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:15", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:30", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}, {"t": "23:45", "bessMw": 0, "loadMw": 0, "deficitMw": 0, "matchedMw": 0, "surplusMw": 0, "generationMw": 0}]	COMPLETE	2026-10-13 15:15:14.331
\.


--
-- Data for Name: LoginOtp; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."LoginOtp" (id, "userId", "codeHash", "expiresAt", "resendAt", attempts, "consumedAt", "createdAt") FROM stdin;
\.


--
-- Data for Name: Negotiation; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Negotiation" (id, "gesId", "ippId", status, "createdAt", "updatedAt", "selectionId") FROM stdin;
\.


--
-- Data for Name: NegotiationOffer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."NegotiationOffer" (id, "negotiationId", version, "offerType", tariff, "codYear", "bessSummary", "paymentTerms", "changeInLaw", curtailment, "performanceGuarantee", "riskAllocation", "otherTerms", status, "createdById", "createdAt") FROM stdin;
\.


--
-- Data for Name: Permission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Permission" (id, key, description) FROM stdin;
perm_ipp_view	IPP_VIEW	View IPP records
perm_ipp_create	IPP_CREATE	Create IPP records
perm_ipp_edit	IPP_EDIT	Edit IPP records
perm_ges_view	GES_VIEW	View GES accounts
perm_ges_create	GES_CREATE	Create GES accounts
perm_ges_edit	GES_EDIT	Edit GES accounts
perm_evaluation_view	EVALUATION_VIEW	View evaluations
perm_evaluation_edit	EVALUATION_EDIT	Edit evaluations
perm_technical_review	TECHNICAL_REVIEW	Review technical inputs
perm_financial_review	FINANCIAL_REVIEW	Review financial inputs
perm_commercial_review	COMMERCIAL_REVIEW	Review commercial terms
perm_tariff_review	TARIFF_REVIEW	Review tariffs
perm_negotiation_create	NEGOTIATION_CREATE	Create negotiation offers
perm_negotiation_approve	NEGOTIATION_APPROVE	Approve negotiation offers
perm_psoa_view	PSOA_VIEW	View PSOA checklists
perm_psoa_create	PSOA_CREATE	Update PSOA checklists
perm_dealbook_view	DEALBOOK_VIEW	View dealbooks
perm_dealbook_create	DEALBOOK_CREATE	Create dealbooks
perm_document_view	DOCUMENT_VIEW	View documents
perm_document_upload	DOCUMENT_UPLOAD	Upload documents
perm_audit_view	AUDIT_VIEW	View the audit log
perm_ges_profile_edit	GES_PROFILE_EDIT	Edit allowed GES profile fields
perm_requirement_view	REQUIREMENT_VIEW	View GES requirements
perm_requirement_edit	REQUIREMENT_EDIT	Edit GES requirements
perm_selection_view	SELECTION_VIEW	View GES IPP selections
perm_selection_create	SELECTION_CREATE	Select an IPP for a GES requirement
perm_commercial_requirement_view	COMMERCIAL_REQUIREMENT_VIEW	View commercial requirements
perm_commercial_requirement_create	COMMERCIAL_REQUIREMENT_CREATE	Submit a commercial requirement
\.


--
-- Data for Name: Psoa; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Psoa" (id, "gesId", "ippId", items, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: QuestionnaireAnswer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."QuestionnaireAnswer" (id, "gesId", "questionKey", value, "updatedById", "updatedAt", "ippId", rating) FROM stdin;
cmv6vs6ov000lryjl49jm2f0f	ges_1791904510208	experience-solar-capacity-commissioned	5	usr_ges_1791904510208_login	2026-10-13 16:24:24.739	ipp_1791901322213	\N
cmv6tuix106pmmk3ormv6aqe2	ges_1791904510208	ehv-how-augmentation-would-be-managed	y	usr_ges_1791904510208_login	2026-10-13 16:03:46.497	ipp_1791901322469	\N
cmv6vn7c60007ryjlmjzohvzk	ges_1791904510208	section:experience		usr_ges_1791904510208_login	2026-10-13 16:24:24.739	ipp_1791901322213	6
cmv6vs6qn00f7ryjlsmbw50o0	ges_1791904510208	section:ehv		usr_ges_1791904510208_login	2026-10-13 16:24:24.739	ipp_1791901322213	10
cmv6tuiyr072omk3oyzsvhboo	ges_1791904510208	section:experience		usr_ges_1791904510208_login	2026-10-13 16:03:46.497	ipp_1791901322469	10
cmv6tuiyr072qmk3ozupiadrc	ges_1791904510208	section:ehv		usr_ges_1791904510208_login	2026-10-13 16:03:46.497	ipp_1791901322469	10
cmv6tuiyr072smk3o50savxpm	ges_1791904510208	section:technical		usr_ges_1791904510208_login	2026-10-13 16:03:46.497	ipp_1791901322469	10
cmv6tuiys072umk3oqba1ioc3	ges_1791904510208	section:fdre		usr_ges_1791904510208_login	2026-10-13 16:03:46.497	ipp_1791901322469	10
cmv6tuiys072wmk3oifrcda3r	ges_1791904510208	section:bess		usr_ges_1791904510208_login	2026-10-13 16:03:46.497	ipp_1791901322469	10
cmv6tuiys072ymk3o2b1ddzkj	ges_1791904510208	section:epc		usr_ges_1791904510208_login	2026-10-13 16:03:46.497	ipp_1791901322469	10
cmv6tuiys0730mk3orimbcs5w	ges_1791904510208	section:programme		usr_ges_1791904510208_login	2026-10-13 16:03:46.497	ipp_1791901322469	10
cmv6tuiyt0732mk3o9sygc589	ges_1791904510208	section:capex		usr_ges_1791904510208_login	2026-10-13 16:03:46.497	ipp_1791901322469	10
cmv6tuiyt0734mk3omz6blb3a	ges_1791904510208	section:finance		usr_ges_1791904510208_login	2026-10-13 16:03:46.497	ipp_1791901322469	10
cmv6tuiyt0736mk3oyqzffmtx	ges_1791904510208	section:tariff		usr_ges_1791904510208_login	2026-10-13 16:03:46.497	ipp_1791901322469	10
cmv6tuiyt0738mk3o8dth1xbf	ges_1791904510208	section:sustainability		usr_ges_1791904510208_login	2026-10-13 16:03:46.497	ipp_1791901322469	10
cmv6tuiyt073amk3ormf96mb5	ges_1791904510208	section:regulatory		usr_ges_1791904510208_login	2026-10-13 16:03:46.497	ipp_1791901322469	10
cmv6tuiyu073cmk3o7aljzmx8	ges_1791904510208	section:captive		usr_ges_1791904510208_login	2026-10-13 16:03:46.497	ipp_1791901322469	10
cmv6tuiyu073emk3ozkqidrui	ges_1791904510208	section:operations		usr_ges_1791904510208_login	2026-10-13 16:03:46.497	ipp_1791901322469	10
\.


--
-- Data for Name: RedFlag; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."RedFlag" (id, "ippId", "gesId", category, severity, code, title, detail, active) FROM stdin;
cmv6tohje05nymk3o4qne65v6	ipp_1791901323443	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6tohje05nzmk3owde3uxry	ipp_1791901323443	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
cmv6tohuu05rymk3ole2erqkl	ipp_1791901322836	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6tohuu05rzmk3o344d4d3d	ipp_1791901322836	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
cmv6toi5205vymk3ob1h8ek76	ipp_1791901324175	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6toi5205vzmk3oqet6fuxr	ipp_1791901324175	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
cmv6toifg05zymk3o31jpf3f2	ipp_1791901322663	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6toifg05zzmk3orppa714z	ipp_1791901322663	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
cmv6toiwm063ymk3oyldxhoxk	ipp_1791901324487	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6toiwm063zmk3o9i4r9om0	ipp_1791901324487	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
cmv6toj6z067ymk3oel1tn1fi	ipp_1791901323881	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6toj6z067zmk3o9scbfcfv	ipp_1791901323881	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
cmv6tojgl06bymk3os7adhulv	ipp_1791901323738	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6tojgl06bzmk3oqmfx3a0a	ipp_1791901323738	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
cmv6tojqy06fymk3op53gpewx	ipp_1791901325112	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6tojqy06fzmk3onoijequo	ipp_1791901325112	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
cmv6toka706nxmk3opkh0a609	ipp_1791901324956	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6toka706nymk3o1sbmehkf	ipp_1791901324956	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
cmv6tohda05lymk3owckywi41	ipp_1791901322977	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6tohda05lzmk3oxe74tdcd	ipp_1791901322977	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
cmv6tohp705pymk3ov1vqfyn7	ipp_1791901323592	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6tohp705pzmk3oh2n3y6gt	ipp_1791901323592	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
cmv6tohzw05tymk3ooplzcuqy	ipp_1791901324035	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6tohzw05tzmk3oics8hpau	ipp_1791901324035	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
cmv6toiah05xymk3o10iq5uzx	ipp_1791901322469	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6toiah05xzmk3oid7iszrw	ipp_1791901322469	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
cmv6toilv061ymk3oy551or0o	ipp_1791901324785	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6toilv061zmk3oazdenf9r	ipp_1791901324785	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
cmv6toj1o065ymk3otno8g7hn	ipp_1791901324322	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6toj1o065zmk3og6uoy05q	ipp_1791901324322	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
cmv6tojbz069ymk3ox7aw2mu4	ipp_1791901322213	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6tojbz069zmk3owafvab25	ipp_1791901322213	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
cmv6tojlw06dymk3om2bs4xxm	ipp_1791901323132	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6tojlw06dzmk3ozuyj0v6c	ipp_1791901323132	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
cmv6tojw106hymk3osjt4jsfj	ipp_1791901324632	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6tojw106hzmk3ot67awtvo	ipp_1791901324632	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
cmv6tok5e06lxmk3olqduknul	ipp_1791901323285	ges_1791904510208	TECHNICAL	CRITICAL	MISSING_P50_P90	Missing P50/P90	The generation case does not contain both a P50 and a P90 energy figure.	t
cmv6tok5e06lymk3ozwrtyeqf	ipp_1791901323285	ges_1791904510208	EXECUTION	MEDIUM	COD_AFTER_GES_TARGET	COD after GES target	The IPP COD is later than this GES target year.	t
\.


--
-- Data for Name: RefreshToken; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."RefreshToken" (id, "userId", "tokenHash", "expiresAt", "revokedAt", "createdAt") FROM stdin;
cmv803m8f0003quf0423b6j1u	usr_ges_1791904510208_login	1591cea2d98e7fd2f2d870a0a18200504a919559d4d26e29de743fb601012fd7	2026-10-21 11:02:40.719	2026-10-14 11:29:58.982	2026-10-14 11:02:40.72
cmv80o8fl0005quf0u42r7kw8	usr_newra_grids	1551ff217afc68be1848bd35df346f70c895a5b71f01c346e5a502f7065afb35	2026-10-21 11:18:42.608	2026-10-14 11:34:31.739	2026-10-14 11:18:42.609
cmv812qc80007quf0edxn5s4h	usr_ges_1791904510208_login	2806c5fd3b8ee194709b734db2a614b6dc7fefb0a334d6b506d46988bf0f42d3	2026-10-21 11:29:59	\N	2026-10-14 11:29:59.001
cmv818ktl0009quf0mgxkijqn	usr_newra_grids	95a21d78d63d8b1f5caa91bf7cff7f330ce83449475c8ce0951ea665ae139b06	2026-10-21 11:34:31.784	\N	2026-10-14 11:34:31.785
cmv6qbli80001qalmvpguyp5b	usr_newra_grids	520d758885ea398f15b483f894c403849aed1f235470470d43638bfcebe0962d	2026-10-20 13:41:10.686	\N	2026-10-13 13:41:10.688
cmv6qblmk0003qalmss8dk9gi	usr_newra_grids	b531296185008595285b8650a436094e097e53579586e3fe784af37e7b9d6d10	2026-10-20 13:41:10.841	\N	2026-10-13 13:41:10.844
cmv6qd68l0005qalmqnchu5wn	usr_newra_grids	90ccd4e6ef684a3dd177605ccfecea128b485e0a5af8428f0a1f103114f78536	2026-10-20 13:42:24.209	\N	2026-10-13 13:42:24.213
cmv6rcezf002jqalm3v8ke3xd	usr_newra_grids	34bb5b6db3e0f1aeeee67b29791fb0af93b54f508d9f67066152617057c2cfb4	2026-10-20 14:09:48.504	\N	2026-10-13 14:09:48.508
cmv6rs4ys0001146gipro7s9z	usr_newra_grids	874dfb49efc33737ea6e52d30319d9156f1538a47690d9d3319af30dc4cb4801	2026-10-20 14:22:02.017	\N	2026-10-13 14:22:02.02
cmv6rtpz400fz146getcye6rf	usr_newra_grids	d2b43a03e3273bd1f28a4c4099271bd77b44ae7bd5789ff180e86a0b7fd3e117	2026-10-20 14:23:15.903	\N	2026-10-13 14:23:15.904
cmv6su3d10003v8pb88vrdivp	usr_newra_grids	be87838db41a7331619e3896e8e333782c9da86985116a05c267a434f0cec0b2	2026-10-20 14:51:32.868	\N	2026-10-13 14:51:32.869
cmv6s6tyk0003694ijwh7vnr3	usr_newra_grids	8b03e64cad04d398902ed95cfc0cfc51094c9b12e0fa97e7a04441c2d3f81845	2026-10-20 14:33:27.595	\N	2026-10-13 14:33:27.596
cmv6sa61v0001j1ay9v1y0m8y	usr_newra_grids	d6ad435e9b59b541263a0bc7c78542990c4853d3dd56a7ac3e80ee0dc5bd0846	2026-10-20 14:36:03.234	\N	2026-10-13 14:36:03.236
cmv6sfazu00012v9zaukq8qsj	usr_newra_grids	8ea51cb102323745a369216ebf4ed0de1ec2ea7d5f07ee7719e7694a5c28e37a	2026-10-20 14:40:02.92	\N	2026-10-13 14:40:02.923
cmv6ssrt40001v8pbnqnf40tf	usr_newra_grids	c91a4c1dd839e91569403b701bcebeb3084e28e6d26b360db37eb34c469e69b3	2026-10-20 14:50:31.239	\N	2026-10-13 14:50:31.241
cmv6swyf40009v8pb41n7kp40	usr_newra_grids	72a6a984108ef5547bd0b5d0db4633205f0fc6579b2cf59db84edad238517b46	2026-10-20 14:53:46.43	\N	2026-10-13 14:53:46.432
cmv6swyf6000bv8pbguwypkmr	usr_newra_grids	d4f84b28f8a5ee492d914520fa9f6011233e4fcfd65fe9c4f63e68a185dc0844	2026-10-20 14:53:46.433	\N	2026-10-13 14:53:46.435
cmv6tkdgw0543mk3op0ell874	usr_newra_grids	af1f85b03bf3279b6de7274c9ff6e52b6ef27c67ffbc736418f0cd4ab02390f3	2026-10-20 15:11:59.021	\N	2026-10-13 15:11:59.024
cmv6v3zyj0cq6mk3oyh2jdvnt	usr_newra_grids	d33a07fbf27fdd8c866019a45dbc0e63efb4ce8a05ae6b0bb913070326573330	2026-10-20 15:55:14.25	\N	2026-10-13 15:55:14.252
cmv6v8gm80cqamk3oz2jj5bx1	usr_newra_grids	9665e8f11d2e8df042aecd2eb96ffb26703b884fe6ec9bc05023939ef2dc80dc	2026-10-20 15:58:42.464	\N	2026-10-13 15:58:42.465
cmv7ztxq30001quf0tehuh32s	usr_newra_grids	71d5d74598626701ee3866546f8422de944f8e92a7ea39144505bbce3c7a9c9a	2026-10-21 10:55:09.049	2026-10-14 11:18:42.591	2026-10-14 10:55:09.05
cmv6vb6jb0001crir6ahl3a8p	usr_ges_1791904510208_login	7ebebef8cc2cafe8b171fc15bd5d2db7616bb9c6addd4fd173cb8124a1acc639	2026-10-20 16:00:49.366	\N	2026-10-13 16:00:49.367
cmv6vmg5c0001ryjlk9lhg4hp	usr_newra_grids	54ab6d94f9655f1b576cd5b9e7a758cb188f7eeaf2b0d16a03171cf9f30e364f	2026-10-20 16:09:35.039	\N	2026-10-13 16:09:35.04
cmv6vn76b0003ryjl6uu8af1k	usr_newra_grids	d78756564de31872840c0252ee86dde131d8376932bb1d9f08baab4086b7c5ed	2026-10-20 16:10:10.066	\N	2026-10-13 16:10:10.067
cmv6vo4ml000hryjl1dshzjvb	usr_newra_grids	8101d578c1307408aee84c801d2df477b5d4f3e2a69088e56fc6d8b408b04531	2026-10-20 16:10:53.42	\N	2026-10-13 16:10:53.421
cmv6vvwwy00v9ryjlblx1zbmj	usr_ges_1791904510208_login	015ec27fb5683d2dc674452d07345276aeeced01b2410736f53452820b80f9ba	2026-10-20 16:16:56.673	\N	2026-10-13 16:16:56.675
cmv6vyqyj0001473dxk1d9v6v	usr_newra_grids	5c4852ff9c90d080ac026fdd5f6d01172cf02134b661fa72b0734282d4d5b934	2026-10-20 16:19:08.922	\N	2026-10-13 16:19:08.924
cmv6vz0wz0003473d7286ve6i	usr_newra_grids	81a269e42bdae0fa2bcfebe77654661a08cbfbe2f58f0ae1ccb7223b8b4bc241	2026-10-20 16:19:21.826	\N	2026-10-13 16:19:21.828
cmv7s787h0005bpnzw5lfc1jz	usr_ges_1791904510208_login	23e5c7f70424f22466cdac34254df951a9e53cdb50ad87d0f52ebed5d1b9585d	2026-10-21 07:21:32.236	\N	2026-10-14 07:21:32.237
cmv7s787i0007bpnzmdce1unc	usr_ges_1791904510208_login	d89fe07235487740172475a8178486d5ea97fea4af4b17fc09ceb05122b9036b	2026-10-21 07:21:32.238	\N	2026-10-14 07:21:32.239
cmv7wdlf80007z9o03q5wn3d8	usr_newra_grids	bfa8fc38cdb9777d28476dd261a41598b97fb816c85d62b0bab289b0ff1fef65	2026-10-21 09:18:27.764	\N	2026-10-14 09:18:27.765
cmv7xeyqp000382tetffjirpi	usr_newra_grids	6526eccdaea1e4cc0bc6200aa4d417469010257727b24d6169dcf938e97a3eba	2026-10-21 09:47:31.295	\N	2026-10-14 09:47:31.297
cmv7y75x2000b82tezkqaslij	usr_newra_grids	b1c4894d4b78eeb27517aa2f68f4599e0d8755233974fcf0601f908aac5dd389	2026-10-21 10:09:26.966	\N	2026-10-14 10:09:26.965
cmv7zak0h0017t8x8k4olxfx7	usr_newra_grids	84d2b59072950d9170ae046ac6d6ae364e359f70e854ad11961720986cb873eb	2026-10-21 10:40:04.816	2026-10-14 10:55:09.036	2026-10-14 10:40:04.817
\.


--
-- Data for Name: Role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Role" (id, name, description) FROM stdin;
role_admin	ADMIN	NewRa Grids. Full platform access, including acting on behalf of a GES.
role_newra_admin	NEWRA_ADMIN	NewRa operations. Creates GES accounts and global IPP records without owning an IPP.
role_evaluator	EVALUATOR	Runs evaluations and keeps GES and IPP inputs current.
role_commercial_reviewer	COMMERCIAL_REVIEWER	Reviews tariff, negotiation and commercial terms.
role_technical_reviewer	TECHNICAL_REVIEWER	Reviews generation, BESS, EHV and engineering evidence.
role_finance_reviewer	FINANCE_REVIEWER	Reviews CAPEX, financing and tariff sustainability.
role_viewer	VIEWER	Read-only access to GES, IPP, evaluation and dealbook.
role_ges_admin	GES_ADMIN	Own GES access for profile, requirement, IPP selection and commercial requirement.
role_ges_user	GES_USER	Own GES access for profile, requirement, IPP catalogue, selection and commercial requirement.
\.


--
-- Data for Name: RolePermission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."RolePermission" ("roleId", "permissionId") FROM stdin;
role_admin	perm_ipp_view
role_admin	perm_ipp_create
role_admin	perm_ipp_edit
role_admin	perm_ges_view
role_admin	perm_ges_create
role_admin	perm_ges_edit
role_admin	perm_evaluation_view
role_admin	perm_evaluation_edit
role_admin	perm_technical_review
role_admin	perm_financial_review
role_admin	perm_commercial_review
role_admin	perm_tariff_review
role_admin	perm_negotiation_create
role_admin	perm_negotiation_approve
role_admin	perm_psoa_view
role_admin	perm_psoa_create
role_admin	perm_dealbook_view
role_admin	perm_dealbook_create
role_admin	perm_document_view
role_admin	perm_document_upload
role_admin	perm_audit_view
role_evaluator	perm_ipp_view
role_evaluator	perm_ipp_create
role_evaluator	perm_ipp_edit
role_evaluator	perm_ges_view
role_evaluator	perm_ges_edit
role_evaluator	perm_evaluation_view
role_evaluator	perm_evaluation_edit
role_evaluator	perm_psoa_view
role_evaluator	perm_psoa_create
role_evaluator	perm_dealbook_view
role_evaluator	perm_document_view
role_evaluator	perm_document_upload
role_evaluator	perm_audit_view
role_evaluator	perm_negotiation_create
role_commercial_reviewer	perm_ipp_view
role_commercial_reviewer	perm_ges_view
role_commercial_reviewer	perm_evaluation_view
role_commercial_reviewer	perm_commercial_review
role_commercial_reviewer	perm_tariff_review
role_commercial_reviewer	perm_negotiation_create
role_commercial_reviewer	perm_negotiation_approve
role_commercial_reviewer	perm_psoa_view
role_commercial_reviewer	perm_dealbook_view
role_commercial_reviewer	perm_document_view
role_technical_reviewer	perm_ipp_view
role_technical_reviewer	perm_ges_view
role_technical_reviewer	perm_evaluation_view
role_technical_reviewer	perm_technical_review
role_technical_reviewer	perm_document_view
role_technical_reviewer	perm_document_upload
role_technical_reviewer	perm_psoa_view
role_finance_reviewer	perm_ipp_view
role_finance_reviewer	perm_ges_view
role_finance_reviewer	perm_evaluation_view
role_finance_reviewer	perm_financial_review
role_finance_reviewer	perm_tariff_review
role_finance_reviewer	perm_dealbook_view
role_finance_reviewer	perm_document_view
role_finance_reviewer	perm_psoa_view
role_viewer	perm_ipp_view
role_viewer	perm_ges_view
role_viewer	perm_evaluation_view
role_viewer	perm_psoa_view
role_viewer	perm_dealbook_view
role_viewer	perm_document_view
role_ges_user	perm_ipp_view
role_ges_user	perm_ges_view
role_ges_user	perm_evaluation_view
role_ges_user	perm_psoa_view
role_ges_user	perm_dealbook_view
role_ges_user	perm_document_view
role_evaluator	perm_ges_create
role_admin	perm_requirement_view
role_admin	perm_selection_view
role_admin	perm_commercial_requirement_view
role_admin	perm_ges_profile_edit
role_admin	perm_requirement_edit
role_admin	perm_selection_create
role_admin	perm_commercial_requirement_create
role_newra_admin	perm_ipp_view
role_newra_admin	perm_ipp_create
role_newra_admin	perm_ipp_edit
role_newra_admin	perm_ges_view
role_newra_admin	perm_ges_create
role_newra_admin	perm_ges_edit
role_newra_admin	perm_evaluation_view
role_newra_admin	perm_evaluation_edit
role_newra_admin	perm_document_view
role_newra_admin	perm_document_upload
role_newra_admin	perm_psoa_view
role_newra_admin	perm_dealbook_view
role_newra_admin	perm_requirement_view
role_newra_admin	perm_selection_view
role_newra_admin	perm_commercial_requirement_view
role_newra_admin	perm_ges_profile_edit
role_newra_admin	perm_requirement_edit
role_newra_admin	perm_selection_create
role_newra_admin	perm_commercial_requirement_create
role_evaluator	perm_requirement_view
role_evaluator	perm_selection_view
role_evaluator	perm_commercial_requirement_view
role_evaluator	perm_ges_profile_edit
role_evaluator	perm_requirement_edit
role_evaluator	perm_selection_create
role_evaluator	perm_commercial_requirement_create
role_commercial_reviewer	perm_requirement_view
role_commercial_reviewer	perm_selection_view
role_commercial_reviewer	perm_commercial_requirement_view
role_technical_reviewer	perm_requirement_view
role_technical_reviewer	perm_selection_view
role_finance_reviewer	perm_requirement_view
role_finance_reviewer	perm_selection_view
role_viewer	perm_requirement_view
role_viewer	perm_selection_view
role_viewer	perm_commercial_requirement_view
role_ges_admin	perm_ipp_view
role_ges_admin	perm_ges_view
role_ges_admin	perm_evaluation_view
role_ges_admin	perm_document_view
role_ges_admin	perm_requirement_view
role_ges_admin	perm_selection_view
role_ges_admin	perm_commercial_requirement_view
role_ges_admin	perm_ges_profile_edit
role_ges_admin	perm_requirement_edit
role_ges_admin	perm_selection_create
role_ges_admin	perm_commercial_requirement_create
role_ges_user	perm_requirement_view
role_ges_user	perm_selection_view
role_ges_user	perm_commercial_requirement_view
role_ges_user	perm_ges_profile_edit
role_ges_user	perm_requirement_edit
role_ges_user	perm_selection_create
role_ges_user	perm_commercial_requirement_create
role_ges_admin	perm_ges_edit
role_ges_user	perm_ges_edit
\.


--
-- Data for Name: SuitabilityConfig; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."SuitabilityConfig" (id, name, active, weights, "tariffFloor", "tariffCeiling", illustrative, "createdAt", "updatedAt") FROM stdin;
suitability_default	Default GES suitability weights	t	{"codFit": 8, "bessFit": 12, "loadMatch": 16, "tariffFit": 8, "financialFit": 10, "technicalFit": 10, "regulatoryFit": 5, "technologyFit": 10, "energyCoverage": 14, "connectivityFit": 7}	3.2	4.6	t	2026-10-02 16:01:05.874	2026-10-02 16:01:05.874
\.


--
-- Data for Name: TariffNegotiation; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."TariffNegotiation" (id, "gesId", "ippId", rounds, "updatedById", "createdAt", "updatedAt") FROM stdin;
cmv6txpm30cngmk3o9v1tbgms	ges_1791904510208	ipp_1791901324175	[{"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
cmv6txpm30cnimk3o46uvu9o4	ges_1791904510208	ipp_1791901324322	[{"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
cmv6txpm30cnkmk3omdkmhrxb	ges_1791904510208	ipp_1791901324487	[{"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
cmv6txpm30cnmmk3opibjn0m2	ges_1791904510208	ipp_1791901324632	[{"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
cmv6txpm30cnomk3osrdv2ukc	ges_1791904510208	ipp_1791901324785	[{"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
cmv6txpm40cnqmk3o48nb61x9	ges_1791904510208	ipp_1791901324956	[{"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
cmv6txpm40cnsmk3oktb7w0j0	ges_1791904510208	ipp_1791901325112	[{"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
cmv6txpm20cnemk3ox91tr93d	ges_1791904510208	ipp_1791901324035	[{"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
cmv6txpm00cmsmk3o86nvjv43	ges_1791904510208	ipp_1791901322213	[{"gesOffer": "600", "ippTariff": "500", "finalisedRate": "450"}, {"gesOffer": "500", "ippTariff": "460", "finalisedRate": "480"}, {"gesOffer": "200", "ippTariff": "222", "finalisedRate": "212"}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
cmv6txpm00cmumk3o6g6nvz4t	ges_1791904510208	ipp_1791901322469	[{"gesOffer": "650", "ippTariff": "1000", "finalisedRate": ""}, {"gesOffer": "500", "ippTariff": "900", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "44", "ippTariff": "22", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
cmv6txpm10cmwmk3o5ffjytzr	ges_1791904510208	ipp_1791901322663	[{"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
cmv6txpm10cmymk3ompr2874w	ges_1791904510208	ipp_1791901322836	[{"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
cmv6txpm10cn0mk3o6z6h6hqy	ges_1791904510208	ipp_1791901322977	[{"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
cmv6txpm10cn4mk3oky4at6pr	ges_1791904510208	ipp_1791901323285	[{"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
cmv6txpm20cn6mk3oqraq0667	ges_1791904510208	ipp_1791901323443	[{"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
cmv6txpm20cn8mk3onqs8dryk	ges_1791904510208	ipp_1791901323592	[{"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
cmv6txpm20cnamk3o41go16oi	ges_1791904510208	ipp_1791901323738	[{"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
cmv6txpm20cncmk3o7yht6tp8	ges_1791904510208	ipp_1791901323881	[{"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
cmv6txpm10cn2mk3ozn2k6i1a	ges_1791904510208	ipp_1791901323132	[{"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}, {"gesOffer": "", "ippTariff": "", "finalisedRate": ""}]	usr_newra_grids	2026-10-13 15:22:21.288	2026-10-14 10:36:34.886
\.


--
-- Data for Name: Task; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Task" (id, "gesId", "ippId", title, "dueDate", "ownerId", "pendingFrom", priority, status, "createdAt") FROM stdin;
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."User" (id, email, name, "passwordHash", title, active, "createdAt", "updatedAt", "gesId", "accessStatus", phone) FROM stdin;
usr_newra_grids	admin@newragrids.com	NewRa Grids	$2b$10$RXP9H/sSRaaYuaTqLvh7KONg1Cw7TANCoa0zFHKmLHtp1gn4nKGaC	NewRa Grids	t	2026-10-04 20:54:12.102	2026-10-14 10:55:07.952	\N	APPROVED	
usr_ges_1791904510208_login	rohithiwrale5552@gmail.com	Rohit H	$2b$10$KSGyhehaALuU6pwY.pLz8uiKxq4lv9JkQNH6jW9LnOA1WE.gM5/RS	Rohit H	t	2026-10-13 15:15:10.401	2026-10-13 15:15:10.401	ges_1791904510208	APPROVED	
\.


--
-- Data for Name: UserRole; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."UserRole" ("userId", "roleId") FROM stdin;
usr_newra_grids	role_admin
usr_ges_1791904510208_login	role_ges_admin
\.


--
-- Name: Activity Activity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Activity"
    ADD CONSTRAINT "Activity_pkey" PRIMARY KEY (id);


--
-- Name: AuditLog AuditLog_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditLog"
    ADD CONSTRAINT "AuditLog_pkey" PRIMARY KEY (id);


--
-- Name: CommercialRequirement CommercialRequirement_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CommercialRequirement"
    ADD CONSTRAINT "CommercialRequirement_pkey" PRIMARY KEY (id);


--
-- Name: ComparisonIPP ComparisonIPP_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ComparisonIPP"
    ADD CONSTRAINT "ComparisonIPP_pkey" PRIMARY KEY ("comparisonId", "ippId");


--
-- Name: Comparison Comparison_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Comparison"
    ADD CONSTRAINT "Comparison_pkey" PRIMARY KEY (id);


--
-- Name: CriticalGateResult CriticalGateResult_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CriticalGateResult"
    ADD CONSTRAINT "CriticalGateResult_pkey" PRIMARY KEY (id);


--
-- Name: CriticalGate CriticalGate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CriticalGate"
    ADD CONSTRAINT "CriticalGate_pkey" PRIMARY KEY (id);


--
-- Name: Dealbook Dealbook_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Dealbook"
    ADD CONSTRAINT "Dealbook_pkey" PRIMARY KEY (id);


--
-- Name: DocumentVersion DocumentVersion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DocumentVersion"
    ADD CONSTRAINT "DocumentVersion_pkey" PRIMARY KEY (id);


--
-- Name: Document Document_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Document"
    ADD CONSTRAINT "Document_pkey" PRIMARY KEY (id);


--
-- Name: GESConsumer GESConsumer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GESConsumer"
    ADD CONSTRAINT "GESConsumer_pkey" PRIMARY KEY (id);


--
-- Name: GESIPPSelection GESIPPSelection_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GESIPPSelection"
    ADD CONSTRAINT "GESIPPSelection_pkey" PRIMARY KEY (id);


--
-- Name: GESLoadProfile GESLoadProfile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GESLoadProfile"
    ADD CONSTRAINT "GESLoadProfile_pkey" PRIMARY KEY (id);


--
-- Name: GESRequirementIPP GESRequirementIPP_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GESRequirementIPP"
    ADD CONSTRAINT "GESRequirementIPP_pkey" PRIMARY KEY (id);


--
-- Name: GESRequirement GESRequirement_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GESRequirement"
    ADD CONSTRAINT "GESRequirement_pkey" PRIMARY KEY (id);


--
-- Name: GES GES_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GES"
    ADD CONSTRAINT "GES_pkey" PRIMARY KEY (id);


--
-- Name: IPPBESSProfile IPPBESSProfile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPBESSProfile"
    ADD CONSTRAINT "IPPBESSProfile_pkey" PRIMARY KEY (id);


--
-- Name: IPPCapexItem IPPCapexItem_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPCapexItem"
    ADD CONSTRAINT "IPPCapexItem_pkey" PRIMARY KEY (id);


--
-- Name: IPPCapexModel IPPCapexModel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPCapexModel"
    ADD CONSTRAINT "IPPCapexModel_pkey" PRIMARY KEY (id);


--
-- Name: IPPEHVProfile IPPEHVProfile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPEHVProfile"
    ADD CONSTRAINT "IPPEHVProfile_pkey" PRIMARY KEY (id);


--
-- Name: IPPEPCProfile IPPEPCProfile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPEPCProfile"
    ADD CONSTRAINT "IPPEPCProfile_pkey" PRIMARY KEY (id);


--
-- Name: IPPEvaluationParameter IPPEvaluationParameter_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPEvaluationParameter"
    ADD CONSTRAINT "IPPEvaluationParameter_pkey" PRIMARY KEY (id);


--
-- Name: IPPEvaluationScore IPPEvaluationScore_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPEvaluationScore"
    ADD CONSTRAINT "IPPEvaluationScore_pkey" PRIMARY KEY (id);


--
-- Name: IPPEvaluation IPPEvaluation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPEvaluation"
    ADD CONSTRAINT "IPPEvaluation_pkey" PRIMARY KEY (id);


--
-- Name: IPPExecutionSchedule IPPExecutionSchedule_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPExecutionSchedule"
    ADD CONSTRAINT "IPPExecutionSchedule_pkey" PRIMARY KEY (id);


--
-- Name: IPPExperience IPPExperience_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPExperience"
    ADD CONSTRAINT "IPPExperience_pkey" PRIMARY KEY (id);


--
-- Name: IPPFinancialModel IPPFinancialModel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPFinancialModel"
    ADD CONSTRAINT "IPPFinancialModel_pkey" PRIMARY KEY (id);


--
-- Name: IPPGenerationProfile IPPGenerationProfile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPGenerationProfile"
    ADD CONSTRAINT "IPPGenerationProfile_pkey" PRIMARY KEY (id);


--
-- Name: IPPProject IPPProject_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPProject"
    ADD CONSTRAINT "IPPProject_pkey" PRIMARY KEY (id);


--
-- Name: IPPRegulatoryProfile IPPRegulatoryProfile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPRegulatoryProfile"
    ADD CONSTRAINT "IPPRegulatoryProfile_pkey" PRIMARY KEY (id);


--
-- Name: IPPSolarProfile IPPSolarProfile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPSolarProfile"
    ADD CONSTRAINT "IPPSolarProfile_pkey" PRIMARY KEY (id);


--
-- Name: IPPSuitability IPPSuitability_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPSuitability"
    ADD CONSTRAINT "IPPSuitability_pkey" PRIMARY KEY (id);


--
-- Name: IPPTariffComponent IPPTariffComponent_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPTariffComponent"
    ADD CONSTRAINT "IPPTariffComponent_pkey" PRIMARY KEY (id);


--
-- Name: IPPTariffModel IPPTariffModel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPTariffModel"
    ADD CONSTRAINT "IPPTariffModel_pkey" PRIMARY KEY (id);


--
-- Name: IPPTariffScenario IPPTariffScenario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPTariffScenario"
    ADD CONSTRAINT "IPPTariffScenario_pkey" PRIMARY KEY (id);


--
-- Name: IPPTechnology IPPTechnology_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPTechnology"
    ADD CONSTRAINT "IPPTechnology_pkey" PRIMARY KEY (id);


--
-- Name: IPPWindProfile IPPWindProfile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPWindProfile"
    ADD CONSTRAINT "IPPWindProfile_pkey" PRIMARY KEY (id);


--
-- Name: IPP IPP_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPP"
    ADD CONSTRAINT "IPP_pkey" PRIMARY KEY (id);


--
-- Name: LoadMatchResult LoadMatchResult_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LoadMatchResult"
    ADD CONSTRAINT "LoadMatchResult_pkey" PRIMARY KEY (id);


--
-- Name: LoginOtp LoginOtp_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LoginOtp"
    ADD CONSTRAINT "LoginOtp_pkey" PRIMARY KEY (id);


--
-- Name: NegotiationOffer NegotiationOffer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NegotiationOffer"
    ADD CONSTRAINT "NegotiationOffer_pkey" PRIMARY KEY (id);


--
-- Name: Negotiation Negotiation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Negotiation"
    ADD CONSTRAINT "Negotiation_pkey" PRIMARY KEY (id);


--
-- Name: Permission Permission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Permission"
    ADD CONSTRAINT "Permission_pkey" PRIMARY KEY (id);


--
-- Name: Psoa Psoa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Psoa"
    ADD CONSTRAINT "Psoa_pkey" PRIMARY KEY (id);


--
-- Name: QuestionnaireAnswer QuestionnaireAnswer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."QuestionnaireAnswer"
    ADD CONSTRAINT "QuestionnaireAnswer_pkey" PRIMARY KEY (id);


--
-- Name: RedFlag RedFlag_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RedFlag"
    ADD CONSTRAINT "RedFlag_pkey" PRIMARY KEY (id);


--
-- Name: RefreshToken RefreshToken_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RefreshToken"
    ADD CONSTRAINT "RefreshToken_pkey" PRIMARY KEY (id);


--
-- Name: RolePermission RolePermission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RolePermission"
    ADD CONSTRAINT "RolePermission_pkey" PRIMARY KEY ("roleId", "permissionId");


--
-- Name: Role Role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Role"
    ADD CONSTRAINT "Role_pkey" PRIMARY KEY (id);


--
-- Name: SuitabilityConfig SuitabilityConfig_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SuitabilityConfig"
    ADD CONSTRAINT "SuitabilityConfig_pkey" PRIMARY KEY (id);


--
-- Name: TariffNegotiation TariffNegotiation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TariffNegotiation"
    ADD CONSTRAINT "TariffNegotiation_pkey" PRIMARY KEY (id);


--
-- Name: Task Task_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT "Task_pkey" PRIMARY KEY (id);


--
-- Name: UserRole UserRole_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_pkey" PRIMARY KEY ("userId", "roleId");


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: AuditLog_entity_entityId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AuditLog_entity_entityId_idx" ON public."AuditLog" USING btree (entity, "entityId");


--
-- Name: CommercialRequirement_gesId_ippId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CommercialRequirement_gesId_ippId_idx" ON public."CommercialRequirement" USING btree ("gesId", "ippId");


--
-- Name: CommercialRequirement_selectionId_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CommercialRequirement_selectionId_createdAt_idx" ON public."CommercialRequirement" USING btree ("selectionId", "createdAt");


--
-- Name: Comparison_gesId_working_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Comparison_gesId_working_idx" ON public."Comparison" USING btree ("gesId", working);


--
-- Name: CriticalGateResult_gateId_ippId_gesId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "CriticalGateResult_gateId_ippId_gesId_key" ON public."CriticalGateResult" USING btree ("gateId", "ippId", "gesId");


--
-- Name: CriticalGate_key_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "CriticalGate_key_key" ON public."CriticalGate" USING btree (key);


--
-- Name: Dealbook_gesId_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Dealbook_gesId_ippId_key" ON public."Dealbook" USING btree ("gesId", "ippId");


--
-- Name: GESIPPSelection_gesId_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "GESIPPSelection_gesId_ippId_key" ON public."GESIPPSelection" USING btree ("gesId", "ippId");


--
-- Name: GESIPPSelection_gesRequirementId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "GESIPPSelection_gesRequirementId_idx" ON public."GESIPPSelection" USING btree ("gesRequirementId");


--
-- Name: GESRequirementIPP_gesRequirementId_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "GESRequirementIPP_gesRequirementId_ippId_key" ON public."GESRequirementIPP" USING btree ("gesRequirementId", "ippId");


--
-- Name: GESRequirement_gesId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "GESRequirement_gesId_key" ON public."GESRequirement" USING btree ("gesId");


--
-- Name: IPPBESSProfile_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IPPBESSProfile_ippId_key" ON public."IPPBESSProfile" USING btree ("ippId");


--
-- Name: IPPCapexModel_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IPPCapexModel_ippId_key" ON public."IPPCapexModel" USING btree ("ippId");


--
-- Name: IPPEHVProfile_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IPPEHVProfile_ippId_key" ON public."IPPEHVProfile" USING btree ("ippId");


--
-- Name: IPPEPCProfile_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IPPEPCProfile_ippId_key" ON public."IPPEPCProfile" USING btree ("ippId");


--
-- Name: IPPEvaluationParameter_evaluationId_key_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IPPEvaluationParameter_evaluationId_key_key" ON public."IPPEvaluationParameter" USING btree ("evaluationId", key);


--
-- Name: IPPEvaluationScore_evaluationId_key_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IPPEvaluationScore_evaluationId_key_key" ON public."IPPEvaluationScore" USING btree ("evaluationId", key);


--
-- Name: IPPEvaluation_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IPPEvaluation_ippId_key" ON public."IPPEvaluation" USING btree ("ippId");


--
-- Name: IPPExecutionSchedule_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IPPExecutionSchedule_ippId_key" ON public."IPPExecutionSchedule" USING btree ("ippId");


--
-- Name: IPPExperience_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IPPExperience_ippId_key" ON public."IPPExperience" USING btree ("ippId");


--
-- Name: IPPFinancialModel_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IPPFinancialModel_ippId_key" ON public."IPPFinancialModel" USING btree ("ippId");


--
-- Name: IPPGenerationProfile_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IPPGenerationProfile_ippId_key" ON public."IPPGenerationProfile" USING btree ("ippId");


--
-- Name: IPPProject_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IPPProject_ippId_key" ON public."IPPProject" USING btree ("ippId");


--
-- Name: IPPRegulatoryProfile_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IPPRegulatoryProfile_ippId_key" ON public."IPPRegulatoryProfile" USING btree ("ippId");


--
-- Name: IPPSolarProfile_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IPPSolarProfile_ippId_key" ON public."IPPSolarProfile" USING btree ("ippId");


--
-- Name: IPPSuitability_gesRequirementId_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IPPSuitability_gesRequirementId_ippId_key" ON public."IPPSuitability" USING btree ("gesRequirementId", "ippId");


--
-- Name: IPPTariffModel_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IPPTariffModel_ippId_key" ON public."IPPTariffModel" USING btree ("ippId");


--
-- Name: IPPTechnology_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IPPTechnology_ippId_key" ON public."IPPTechnology" USING btree ("ippId");


--
-- Name: IPPWindProfile_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IPPWindProfile_ippId_key" ON public."IPPWindProfile" USING btree ("ippId");


--
-- Name: LoadMatchResult_gesId_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "LoadMatchResult_gesId_ippId_key" ON public."LoadMatchResult" USING btree ("gesId", "ippId");


--
-- Name: LoginOtp_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "LoginOtp_userId_idx" ON public."LoginOtp" USING btree ("userId");


--
-- Name: NegotiationOffer_negotiationId_version_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "NegotiationOffer_negotiationId_version_key" ON public."NegotiationOffer" USING btree ("negotiationId", version);


--
-- Name: Negotiation_gesId_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Negotiation_gesId_ippId_key" ON public."Negotiation" USING btree ("gesId", "ippId");


--
-- Name: Negotiation_selectionId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Negotiation_selectionId_key" ON public."Negotiation" USING btree ("selectionId");


--
-- Name: Permission_key_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Permission_key_key" ON public."Permission" USING btree (key);


--
-- Name: Psoa_gesId_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Psoa_gesId_ippId_key" ON public."Psoa" USING btree ("gesId", "ippId");


--
-- Name: QuestionnaireAnswer_gesId_ippId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "QuestionnaireAnswer_gesId_ippId_idx" ON public."QuestionnaireAnswer" USING btree ("gesId", "ippId");


--
-- Name: QuestionnaireAnswer_gesId_ippId_questionKey_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "QuestionnaireAnswer_gesId_ippId_questionKey_key" ON public."QuestionnaireAnswer" USING btree ("gesId", "ippId", "questionKey");


--
-- Name: RedFlag_ippId_gesId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "RedFlag_ippId_gesId_idx" ON public."RedFlag" USING btree ("ippId", "gesId");


--
-- Name: RefreshToken_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "RefreshToken_userId_idx" ON public."RefreshToken" USING btree ("userId");


--
-- Name: Role_name_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Role_name_key" ON public."Role" USING btree (name);


--
-- Name: TariffNegotiation_gesId_ippId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "TariffNegotiation_gesId_ippId_key" ON public."TariffNegotiation" USING btree ("gesId", "ippId");


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: Activity Activity_actorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Activity"
    ADD CONSTRAINT "Activity_actorId_fkey" FOREIGN KEY ("actorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Activity Activity_gesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Activity"
    ADD CONSTRAINT "Activity_gesId_fkey" FOREIGN KEY ("gesId") REFERENCES public."GES"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Activity Activity_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Activity"
    ADD CONSTRAINT "Activity_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AuditLog AuditLog_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditLog"
    ADD CONSTRAINT "AuditLog_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: CommercialRequirement CommercialRequirement_createdById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CommercialRequirement"
    ADD CONSTRAINT "CommercialRequirement_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: CommercialRequirement CommercialRequirement_gesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CommercialRequirement"
    ADD CONSTRAINT "CommercialRequirement_gesId_fkey" FOREIGN KEY ("gesId") REFERENCES public."GES"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CommercialRequirement CommercialRequirement_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CommercialRequirement"
    ADD CONSTRAINT "CommercialRequirement_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CommercialRequirement CommercialRequirement_selectionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CommercialRequirement"
    ADD CONSTRAINT "CommercialRequirement_selectionId_fkey" FOREIGN KEY ("selectionId") REFERENCES public."GESIPPSelection"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ComparisonIPP ComparisonIPP_comparisonId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ComparisonIPP"
    ADD CONSTRAINT "ComparisonIPP_comparisonId_fkey" FOREIGN KEY ("comparisonId") REFERENCES public."Comparison"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ComparisonIPP ComparisonIPP_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ComparisonIPP"
    ADD CONSTRAINT "ComparisonIPP_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Comparison Comparison_gesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Comparison"
    ADD CONSTRAINT "Comparison_gesId_fkey" FOREIGN KEY ("gesId") REFERENCES public."GES"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CriticalGateResult CriticalGateResult_gateId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CriticalGateResult"
    ADD CONSTRAINT "CriticalGateResult_gateId_fkey" FOREIGN KEY ("gateId") REFERENCES public."CriticalGate"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CriticalGateResult CriticalGateResult_gesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CriticalGateResult"
    ADD CONSTRAINT "CriticalGateResult_gesId_fkey" FOREIGN KEY ("gesId") REFERENCES public."GES"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CriticalGateResult CriticalGateResult_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CriticalGateResult"
    ADD CONSTRAINT "CriticalGateResult_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Dealbook Dealbook_gesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Dealbook"
    ADD CONSTRAINT "Dealbook_gesId_fkey" FOREIGN KEY ("gesId") REFERENCES public."GES"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Dealbook Dealbook_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Dealbook"
    ADD CONSTRAINT "Dealbook_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: DocumentVersion DocumentVersion_documentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DocumentVersion"
    ADD CONSTRAINT "DocumentVersion_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES public."Document"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Document Document_gesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Document"
    ADD CONSTRAINT "Document_gesId_fkey" FOREIGN KEY ("gesId") REFERENCES public."GES"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Document Document_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Document"
    ADD CONSTRAINT "Document_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Document Document_ownerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Document"
    ADD CONSTRAINT "Document_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: GESConsumer GESConsumer_gesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GESConsumer"
    ADD CONSTRAINT "GESConsumer_gesId_fkey" FOREIGN KEY ("gesId") REFERENCES public."GES"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: GESIPPSelection GESIPPSelection_createdById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GESIPPSelection"
    ADD CONSTRAINT "GESIPPSelection_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: GESIPPSelection GESIPPSelection_gesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GESIPPSelection"
    ADD CONSTRAINT "GESIPPSelection_gesId_fkey" FOREIGN KEY ("gesId") REFERENCES public."GES"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: GESIPPSelection GESIPPSelection_gesRequirementId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GESIPPSelection"
    ADD CONSTRAINT "GESIPPSelection_gesRequirementId_fkey" FOREIGN KEY ("gesRequirementId") REFERENCES public."GESRequirement"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: GESIPPSelection GESIPPSelection_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GESIPPSelection"
    ADD CONSTRAINT "GESIPPSelection_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: GESIPPSelection GESIPPSelection_updatedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GESIPPSelection"
    ADD CONSTRAINT "GESIPPSelection_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: GESLoadProfile GESLoadProfile_gesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GESLoadProfile"
    ADD CONSTRAINT "GESLoadProfile_gesId_fkey" FOREIGN KEY ("gesId") REFERENCES public."GES"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: GESRequirementIPP GESRequirementIPP_gesRequirementId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GESRequirementIPP"
    ADD CONSTRAINT "GESRequirementIPP_gesRequirementId_fkey" FOREIGN KEY ("gesRequirementId") REFERENCES public."GESRequirement"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: GESRequirementIPP GESRequirementIPP_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GESRequirementIPP"
    ADD CONSTRAINT "GESRequirementIPP_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: GESRequirement GESRequirement_gesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GESRequirement"
    ADD CONSTRAINT "GESRequirement_gesId_fkey" FOREIGN KEY ("gesId") REFERENCES public."GES"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPBESSProfile IPPBESSProfile_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPBESSProfile"
    ADD CONSTRAINT "IPPBESSProfile_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPCapexItem IPPCapexItem_modelId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPCapexItem"
    ADD CONSTRAINT "IPPCapexItem_modelId_fkey" FOREIGN KEY ("modelId") REFERENCES public."IPPCapexModel"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPCapexModel IPPCapexModel_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPCapexModel"
    ADD CONSTRAINT "IPPCapexModel_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPEHVProfile IPPEHVProfile_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPEHVProfile"
    ADD CONSTRAINT "IPPEHVProfile_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPEPCProfile IPPEPCProfile_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPEPCProfile"
    ADD CONSTRAINT "IPPEPCProfile_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPEvaluationParameter IPPEvaluationParameter_evaluationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPEvaluationParameter"
    ADD CONSTRAINT "IPPEvaluationParameter_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES public."IPPEvaluation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPEvaluationScore IPPEvaluationScore_evaluationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPEvaluationScore"
    ADD CONSTRAINT "IPPEvaluationScore_evaluationId_fkey" FOREIGN KEY ("evaluationId") REFERENCES public."IPPEvaluation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPEvaluation IPPEvaluation_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPEvaluation"
    ADD CONSTRAINT "IPPEvaluation_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPExecutionSchedule IPPExecutionSchedule_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPExecutionSchedule"
    ADD CONSTRAINT "IPPExecutionSchedule_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPExperience IPPExperience_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPExperience"
    ADD CONSTRAINT "IPPExperience_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPFinancialModel IPPFinancialModel_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPFinancialModel"
    ADD CONSTRAINT "IPPFinancialModel_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPGenerationProfile IPPGenerationProfile_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPGenerationProfile"
    ADD CONSTRAINT "IPPGenerationProfile_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPProject IPPProject_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPProject"
    ADD CONSTRAINT "IPPProject_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPRegulatoryProfile IPPRegulatoryProfile_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPRegulatoryProfile"
    ADD CONSTRAINT "IPPRegulatoryProfile_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPSolarProfile IPPSolarProfile_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPSolarProfile"
    ADD CONSTRAINT "IPPSolarProfile_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPSuitability IPPSuitability_gesRequirementId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPSuitability"
    ADD CONSTRAINT "IPPSuitability_gesRequirementId_fkey" FOREIGN KEY ("gesRequirementId") REFERENCES public."GESRequirement"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPSuitability IPPSuitability_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPSuitability"
    ADD CONSTRAINT "IPPSuitability_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPTariffComponent IPPTariffComponent_modelId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPTariffComponent"
    ADD CONSTRAINT "IPPTariffComponent_modelId_fkey" FOREIGN KEY ("modelId") REFERENCES public."IPPTariffModel"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPTariffModel IPPTariffModel_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPTariffModel"
    ADD CONSTRAINT "IPPTariffModel_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPTariffScenario IPPTariffScenario_modelId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPTariffScenario"
    ADD CONSTRAINT "IPPTariffScenario_modelId_fkey" FOREIGN KEY ("modelId") REFERENCES public."IPPTariffModel"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPTechnology IPPTechnology_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPTechnology"
    ADD CONSTRAINT "IPPTechnology_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: IPPWindProfile IPPWindProfile_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."IPPWindProfile"
    ADD CONSTRAINT "IPPWindProfile_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: LoadMatchResult LoadMatchResult_gesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LoadMatchResult"
    ADD CONSTRAINT "LoadMatchResult_gesId_fkey" FOREIGN KEY ("gesId") REFERENCES public."GES"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: LoadMatchResult LoadMatchResult_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LoadMatchResult"
    ADD CONSTRAINT "LoadMatchResult_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: LoginOtp LoginOtp_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LoginOtp"
    ADD CONSTRAINT "LoginOtp_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: NegotiationOffer NegotiationOffer_createdById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NegotiationOffer"
    ADD CONSTRAINT "NegotiationOffer_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: NegotiationOffer NegotiationOffer_negotiationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NegotiationOffer"
    ADD CONSTRAINT "NegotiationOffer_negotiationId_fkey" FOREIGN KEY ("negotiationId") REFERENCES public."Negotiation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Negotiation Negotiation_gesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Negotiation"
    ADD CONSTRAINT "Negotiation_gesId_fkey" FOREIGN KEY ("gesId") REFERENCES public."GES"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Negotiation Negotiation_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Negotiation"
    ADD CONSTRAINT "Negotiation_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Negotiation Negotiation_selectionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Negotiation"
    ADD CONSTRAINT "Negotiation_selectionId_fkey" FOREIGN KEY ("selectionId") REFERENCES public."GESIPPSelection"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Psoa Psoa_gesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Psoa"
    ADD CONSTRAINT "Psoa_gesId_fkey" FOREIGN KEY ("gesId") REFERENCES public."GES"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Psoa Psoa_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Psoa"
    ADD CONSTRAINT "Psoa_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: QuestionnaireAnswer QuestionnaireAnswer_gesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."QuestionnaireAnswer"
    ADD CONSTRAINT "QuestionnaireAnswer_gesId_fkey" FOREIGN KEY ("gesId") REFERENCES public."GES"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: QuestionnaireAnswer QuestionnaireAnswer_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."QuestionnaireAnswer"
    ADD CONSTRAINT "QuestionnaireAnswer_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: RedFlag RedFlag_gesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RedFlag"
    ADD CONSTRAINT "RedFlag_gesId_fkey" FOREIGN KEY ("gesId") REFERENCES public."GES"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: RedFlag RedFlag_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RedFlag"
    ADD CONSTRAINT "RedFlag_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: RefreshToken RefreshToken_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RefreshToken"
    ADD CONSTRAINT "RefreshToken_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: RolePermission RolePermission_permissionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RolePermission"
    ADD CONSTRAINT "RolePermission_permissionId_fkey" FOREIGN KEY ("permissionId") REFERENCES public."Permission"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: RolePermission RolePermission_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RolePermission"
    ADD CONSTRAINT "RolePermission_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES public."Role"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TariffNegotiation TariffNegotiation_gesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TariffNegotiation"
    ADD CONSTRAINT "TariffNegotiation_gesId_fkey" FOREIGN KEY ("gesId") REFERENCES public."GES"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TariffNegotiation TariffNegotiation_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TariffNegotiation"
    ADD CONSTRAINT "TariffNegotiation_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Task Task_gesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT "Task_gesId_fkey" FOREIGN KEY ("gesId") REFERENCES public."GES"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Task Task_ippId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT "Task_ippId_fkey" FOREIGN KEY ("ippId") REFERENCES public."IPP"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Task Task_ownerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Task"
    ADD CONSTRAINT "Task_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: UserRole UserRole_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES public."Role"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserRole UserRole_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: User User_gesId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_gesId_fkey" FOREIGN KEY ("gesId") REFERENCES public."GES"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

