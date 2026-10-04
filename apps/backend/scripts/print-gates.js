const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

async function main() {
  const rows = await prisma.criticalGateResult.findMany({
    where: { status: "FAIL", ippId: { in: ["ipp_sungrid", "ipp_novarenewable", "ipp_hybridgreen", "ipp_terragrid"] } },
    include: { gate: true, ipp: true, ges: true },
  });
  for (const row of rows) {
    console.log(`${row.ges.name.slice(0, 18).padEnd(18)} ${row.ipp.name.slice(0, 24).padEnd(24)} ${row.gate.name.padEnd(28)} ${row.rationale}`);
  }
}

main().finally(() => prisma.$disconnect());
