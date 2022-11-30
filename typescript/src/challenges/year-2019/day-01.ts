import { getInputNumberArray } from '../../util/loaders';
import { ChallengeResultFunctions } from 'types';
import { sumNumberArray } from '../../util/array-helpers';

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

const input: number[] = getInputNumberArray(2019, 1);

const part1 = (): number => {
  return sumNumberArray(
    input.map((mass: number) => {
      return getFuel(mass);
    }),
  );
};

const part2 = (): number => {
  return sumNumberArray(
    input.map((mass: number) => {
      return getFuelRecursive(mass);
    }),
  );
};

export const year2019day01: ChallengeResultFunctions = {
  part1: part1,
  part2: part2,
};
