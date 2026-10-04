export interface MilestoneInput {
  name: string;
  durationDays: number;
  leadTimeDays: number;
}

export interface ScheduledMilestone extends MilestoneInput {
  startDay: number;
  endDay: number;
}

export function analyseSchedule(milestones: MilestoneInput[]) {
  let cursor = 0;
  const scheduled: ScheduledMilestone[] = milestones.map((milestone) => {
    const startDay = cursor;
    cursor += milestone.durationDays;
    return { ...milestone, startDay, endDay: cursor };
  });
  const longest = [...milestones].sort((left, right) => right.leadTimeDays - left.leadTimeDays)[0];
  return {
    milestones: scheduled,
    criticalPath: scheduled.map((milestone) => milestone.name),
    totalDays: cursor,
    longestLeadItem: longest?.name ?? "None",
    longestLeadDays: longest?.leadTimeDays ?? 0,
  };
}
