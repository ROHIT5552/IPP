const PUBLIC_PATHS = new Set(['/', '/login', '/signup', '/staff']);

const APP_PATHS = [
  /^\/$/,
  /^\/login$/,
  /^\/signup$/,
  /^\/staff$/,
  /^\/whos-watching$/,
  /^\/ges$/,
  /^\/ges\/new$/,
  /^\/ges\/[^/]+$/,
  /^\/ges\/[^/]+\/(edit|psoa|negotiation|documents|dealbook|comparison|selections|requirements|profile|catalogue)$/,
  /^\/ges\/[^/]+\/catalogue\/[^/]+$/,
  /^\/ipps$/,
  /^\/ipps\/new$/,
  /^\/ipps\/[^/]+$/,
  /^\/ipps\/[^/]+\/edit$/,
  /^\/questionnaire$/,
  /^\/comparison$/,
  /^\/evaluation$/,
  /^\/dashboard$/,
  /^\/ges-access$/,
  /^\/client\/(profile|ipps|requirements|my-ipps)$/,
  /^\/client\/ipps\/[^/]+$/,
];

export function isPublicPath(pathname: string) {
  return PUBLIC_PATHS.has(pathname);
}

export function isKnownPath(pathname: string) {
  return APP_PATHS.some((pattern) => pattern.test(pathname));
}
