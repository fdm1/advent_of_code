export type ChallengeFunction = () => string | number;

export interface ChallengeResultFunctions {
  part1: ChallengeFunction;
  part2?: ChallengeFunction;
}
