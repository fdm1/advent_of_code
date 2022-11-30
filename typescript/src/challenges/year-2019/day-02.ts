import { ChallengeResultFunctions } from 'types';
import { commaSeparatedNumbersToNumberArray } from '../../util/loaders';

const positionToUpdateSteps = 3;
const nextCommandSteps = 4;
const addCommand = 1;
const multiplyCommand = 2;
const endCommand = 99;
const challengeInput: number[] = commaSeparatedNumbersToNumberArray(2019, 2);

interface OpcodeArgs {
  input: number[];
  position?: number;
  noun?: number;
  verb?: number;
}

export const processOpcode = (args: OpcodeArgs): number[] => {
  const input = args.input;
  const position = args.position || 0;

  if (args.noun && args.verb) {
    input[1] = args.noun;
    input[2] = args.verb;
  }
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
  return processOpcode({ input: input, position: position + nextCommandSteps });
};

const part1 = (): number => {
  return processOpcode({ input: challengeInput, noun: 12, verb: 2 })[0];
};

const part2 = (): string => {
  const target = 19690720;
  const floor = 0;
  const ceiling = 1000;
  let noun = floor;
  let verb = floor;

  while (noun < ceiling) {
    verb = floor;
    while (verb < ceiling) {
      try {
        const output = processOpcode({ input: Object.create(challengeInput), noun: noun, verb: verb })[0];
        if (output == target) {
          console.log(output);
          return `noun: ${noun}, verb: ${verb}, output: ${output}, answer: ${100 * noun + verb}`;
        }
      } catch (error) {
        continue;
      }
      verb += 1;
    }
    noun += 1;
  }

  return 'no answer found';
};

export const year2019day02: ChallengeResultFunctions = {
  part1: part1,
  part2: part2,
};
