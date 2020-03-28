import { getInput } from '../../util/loaders';
import { ChallengeResultFunctions } from 'types';

export const getFuel = (mass: number): number => {
  return Math.floor(mass / 3) - 2;
};

export const getFuelRecursive = (mass: number): number => {
  let currentMassFuel = getFuel(mass);
  let totalFuel = 0;
  while (currentMassFuel > 0) {
    totalFuel += currentMassFuel;
    currentMassFuel = getFuel(currentMassFuel);
  }
  return totalFuel;
};

const input: string = getInput(2019, 1);

const part1 = (): number => {
  return input
    .split('\n')
    .map((n: string) => {
      return parseInt(n);
    })
    .map((mass: number) => {
      return getFuel(mass);
    })
    .reduce((sum: number, current: number) => sum + current, 0);
};

const part2 = (): number => {
  return input
    .split('\n')
    .map((n: string) => {
      return parseInt(n);
    })
    .map((mass: number) => {
      return getFuelRecursive(mass);
    })
    .reduce((sum: number, current: number) => sum + current, 0);
};

export const year2019day1: ChallengeResultFunctions = {
  part1: part1,
  part2: part2,
};
