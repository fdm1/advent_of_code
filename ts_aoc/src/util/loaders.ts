import fs from 'fs';

export const getInput = (year: number, day: number): string => {
  return fs.readFileSync(`input/year-${year}/day-${day.toString().padStart(2, '0')}.txt`, 'utf8');
};

export const getInputStringArray = (year: number, day: number): string[] => {
  return getInput(year, day).split('\n');
};

export const getInputNumberArray = (year: number, day: number): number[] => {
  return getInputStringArray(year, day).map((n: string) => {
    return parseInt(n);
  });
};

export const commaSeparatedNumbersToNumberArray = (year: number, day: number): number[] => {
  return getInput(year, day)
    .replace(' ', '')
    .split(',')
    .map((n: string) => {
      return parseInt(n);
    });
};
