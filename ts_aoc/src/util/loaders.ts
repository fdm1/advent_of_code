import fs from 'fs';

export const getInput = (year: number, day: number): string => {
  return fs.readFileSync(`input/year-${year}/day-${day}.txt`, 'utf8');
};

export const getInputStringArray = (year: number, day: number): string[] => {
  return getInput(year, day).split('\n');
};

export const getInputNumberArray = (year: number, day: number): number[] => {
  return getInputStringArray(year, day).map((n: string) => {
    return parseInt(n);
  });
};
