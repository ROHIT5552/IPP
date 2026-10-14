'use client';

import dynamic from 'next/dynamic';

export const FactorChartModal = dynamic(
  () => import('./FactorChartModal').then((mod) => mod.FactorChartModal),
  { ssr: false },
);
