import { ChallengeResultFunctions } from 'types';
import { commaSeparatedNumbersToNumberArray } from '../../util/loaders';

const positionToUpdateSteps = 3;
const nextCommandSteps = 4;
const addCommand = 1;
const multiplyCommand = 2;
const endCommand = 99;
const challengeInput: number[] = commaSeparatedNumbersToNumberArray(2019, 2);

export const processOpcode = (input: number[], position = 0): number[] => {
  if (input[position] === endCommand) {
    return input;
  }
  const command = input[position];
  if (command === addCommand) {
    input[input[position + positionToUpdateSteps]] = input[input[position + 1]] + input[input[position + 2]];
  } else if (command == multiplyCommand) {
    input[input[position + positionToUpdateSteps]] = input[input[position + 1]] * input[input[position + 2]];
  } else {
    throw new Error(`unknown command ${command}`);
  }
  return processOpcode(input, position + nextCommandSteps);
};

const part1 = (): number => {
  challengeInput[1] = 12;
  challengeInput[2] = 2;
  return processOpcode(challengeInput)[0];
};

const part2 = (): number => {
  return challengeInput[0];
};

export const year2019day02: ChallengeResultFunctions = {
  part1: part1,
  part2: part2,
};
