module.exports = {
    root: true,
    parser: '@typescript-eslint/parser',
    parserOptions: {
        sourceType: "module",
    },
    plugins: ['@typescript-eslint', 'jest'],
    env: { "jest": true },
};
