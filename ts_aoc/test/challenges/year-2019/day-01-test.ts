import { NumberInNumberOut } from '@test/test-types';
import { getFuel, getFuelRecursive } from '../../../src/challenges/year-2019/day-01';

const testCases: NumberInNumberOut[] = [
  { input: 12, part1Solution: 2, part2Solution: 2 },
  { input: 14, part1Solution: 2, part2Solution: 2 },
  { input: 1969, part1Solution: 654, part2Solution: 966 },
  { input: 100756, part1Solution: 33583, part2Solution: 50346 },
];

test('getFuel works', () => {
  testCases.map((testCase: NumberInNumberOut) => {
    expect(getFuel(testCase.input)).toEqual(testCase.part1Solution);
  });
});

test('getFuelRecursive works', () => {
  testCases.map((testCase: NumberInNumberOut) => {
    expect(getFuelRecursive(testCase.input)).toEqual(testCase.part2Solution);
  });
});
