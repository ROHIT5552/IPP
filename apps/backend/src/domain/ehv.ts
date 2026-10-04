import { clamp, round } from "./numbers";

export type ConnectivityStatus =
  | "PRELIMINARY"
  | "UNDER_STUDY"
  | "APPLICATION_SUBMITTED"
  | "APPROVAL_PENDING"
  | "APPROVED";

const STATUS_FACTOR: Record<ConnectivityStatus, number> = {
  PRELIMINARY: 0.55,
  UNDER_STUDY: 0.68,
  APPLICATION_SUBMITTED: 0.8,
  APPROVAL_PENDING: 0.86,
  APPROVED: 1,
};

export function connectivityFitScore(status: ConnectivityStatus, capabilityScore: number): number {
  const capability = clamp(capabilityScore / 5, 0, 1) * 100;
  return round(capability * STATUS_FACTOR[status], 2);
}

export function connectivityRisk(status: ConnectivityStatus): "Low" | "Moderate" | "High" {
  if (status === "APPROVED" || status === "APPROVAL_PENDING") return status === "APPROVED" ? "Low" : "Moderate";
  if (status === "APPLICATION_SUBMITTED" || status === "UNDER_STUDY") return "Moderate";
  return "High";
}
