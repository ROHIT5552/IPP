import { isKnownPath, isPublicPath } from './routes';

describe('app routes', () => {
  it('keeps sign-in and the home page public', () => {
    expect(isPublicPath('/login')).toBe(true);
    expect(isPublicPath('/comparison')).toBe(false);
  });

  it('recognises real workspace routes and rejects unknown addresses', () => {
    expect(isKnownPath('/ges/ges_1/catalogue/ipp_2')).toBe(true);
    expect(isKnownPath('/questionnaire')).toBe(true);
    expect(isKnownPath('/missing-page')).toBe(false);
    expect(isKnownPath('/ges/ges_1/not-a-page')).toBe(false);
  });
});
