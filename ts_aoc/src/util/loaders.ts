import fs from 'fs';

export const getInput = (year: number, day: number): string => {
  return fs.readFileSync(`input/year-${year}/day-${day}.txt`, 'utf8');
};
