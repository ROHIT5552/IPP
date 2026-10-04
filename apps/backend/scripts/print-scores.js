const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

async function main() {
  const rows = await prisma.gESRequirementIPP.findMany({
    include: { ipp: true, requirement: { include: { ges: true } } },
    orderBy: [{ suitabilityScore: "desc" }],
  });
  for (const row of rows) {
    console.log(
      `${row.requirement.ges.name.padEnd(32)} ${row.ipp.name.padEnd(28)} ${row.suitabilityScore.toFixed(1).padStart(6)}  ${row.compatibilityStatus.padEnd(16)} seed ${row.illustrativeSeedStatus}`,
    );
  }
  const nova = rows.filter((row) => row.requirement.gesId === "ges_nova" && row.ippId === "ipp_novarenewable")[0];
  const aster = rows.filter((row) => row.requirement.gesId === "ges_aster" && row.ippId === "ipp_novarenewable")[0];
  console.log("Nova Renewable on Nova Industrial", nova?.suitabilityScore, nova?.compatibilityStatus);
  console.log("Nova Renewable on Aster", aster?.suitabilityScore, aster?.compatibilityStatus);
}

main().finally(() => prisma.$disconnect());
