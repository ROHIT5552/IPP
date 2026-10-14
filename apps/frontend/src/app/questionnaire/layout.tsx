import { pageMetadata } from '../../seo/metadata';

export const metadata = pageMetadata(
  'Questionnaire',
  'Score each independent power producer against the GES questionnaire in NewRa IPP Comparator.',
  '/questionnaire',
);

export default function QuestionnaireLayout({ children }: { children: React.ReactNode }) {
  return children;
}
