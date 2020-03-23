module.exports = {
  plugins: [
    [
      'module-resolver',
      {
        root: ['./src'],
        extensions: [
          '.ts',
          '.js',
          '.json',
        ],
        alias: {
          '@src': './src',
          '@support': './test/support',
        },
      },
    ],
  ],
};