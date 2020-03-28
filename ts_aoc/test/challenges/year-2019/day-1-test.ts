import { NumberInNumberOut } from '@test/test-types';
import { getFuel } from '../../../src/challenges/year-2019/day-1';

const testCases: NumberInNumberOut[] = [
  { input: 12, part1Solution: 2 },
  { input: 14, part1Solution: 2 },
  { input: 1969, part1Solution: 654 },
  { input: 100756, part1Solution: 33583 },
];

test('getFuel works', () => {
  testCases.map((testCase: NumberInNumberOut) => {
    expect(getFuel(testCase.input)).toEqual(testCase.part1Solution);
  });
});
