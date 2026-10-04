module.exports = {
  testEnvironment: 'jsdom',
  moduleFileExtensions: ['ts', 'tsx', 'js'],
  testMatch: ['<rootDir>/src/**/*.test.ts?(x)'],
  transform: {
    '^.+\\.(ts|tsx)$': ['ts-jest', { tsconfig: { jsx: 'react-jsx', esModuleInterop: true, module: 'commonjs' } }],
  },
  setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
};
