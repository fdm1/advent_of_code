// import { getInput } from '@app/util';
import { getInput } from '../../util';
import { ChallengeResultFunctions } from '@app/types';

export const getFuel = (mass: number): number => {
  return Math.floor(mass / 3) - 2;
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

export const year2019day1: ChallengeResultFunctions = {
  part1: part1,
  part2: undefined,
};
