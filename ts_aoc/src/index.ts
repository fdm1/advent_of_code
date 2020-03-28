import { year2019day01 } from './challenges/year-2019/day-01';
import { ChallengeResultFunctions, ChallengeFunction } from 'types';

const challengeResults: { [yearDay: string]: ChallengeResultFunctions } = {
  '2019-01': year2019day01,
};

// eslint-disable-next-line @typescript-eslint/explicit-function-return-type
const runChallenge = (year: string, day: string, part: string) => {
  console.log(`Running challenge for year ${year} day ${day} part ${part}`);
  const key = `${year}-${day}`;

  const functions: ChallengeResultFunctions = challengeResults[key];

  let func: ChallengeFunction | undefined;

  if (part == '1') {
    func = functions.part1;
  } else {
    if (functions.part2) {
      func = functions.part2;
    }
  }

  if (func) {
    console.log(`Result: ${func()}`);
  } else {
    console.log(`...challenge not completed yet`);
  }
};

const [year, day, part] = process.argv.slice(2);
runChallenge(year, day.padStart(2, '0'), part);
