module.exports = {
  presets: ['@babel/preset-typescript'],
  plugins: [
    [
      'module-resolver',
      {
        root: ['./src'],
        extensions: ['.ts', '.js', '.json'],
        alias: {
          '@app': './src',
          '@support': './test/support',
        },
      },
    ],
  ],
};
