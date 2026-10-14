import { readErrorMessage, unwrap } from './http';

describe('http envelope', () => {
  it('joins validation messages and falls back when the body is empty', () => {
    expect(readErrorMessage({ message: ['Email is required', 'Password is too short'] }, 400)).toBe(
      'Email is required Password is too short',
    );
    expect(readErrorMessage(null, 500)).toBe('Request failed (500).');
  });

  it('unwraps the API success envelope', () => {
    expect(unwrap<{ id: string }>({ success: true, data: { id: 'ges_1' } })).toEqual({ id: 'ges_1' });
    expect(unwrap<string>('plain')).toBe('plain');
  });
});
