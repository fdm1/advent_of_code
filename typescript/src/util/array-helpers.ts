export const sumNumberArray = (numArray: number[]): number => {
  return numArray.reduce((sum: number, current: number) => sum + current, 0);
};
