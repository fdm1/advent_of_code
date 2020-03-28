import { TestCase } from '@test/test-types';
import { processOpcode } from '../../../src/challenges/year-2019/day-02';

const testCases: TestCase[] = [
  { input: [1, 0, 0, 0, 99], part1Solution: [2, 0, 0, 0, 99], part2Solution: [] },
  { input: [2, 3, 0, 3, 99], part1Solution: [2, 3, 0, 6, 99], part2Solution: [] },
  { input: [2, 4, 4, 5, 99, 0], part1Solution: [2, 4, 4, 5, 99, 9801], part2Solution: [] },
  { input: [1, 1, 1, 4, 99, 5, 6, 0, 99], part1Solution: [30, 1, 1, 4, 2, 5, 6, 0, 99], part2Solution: [] },
];

test('processOpcode works', () => {
  testCases.map((testCase: TestCase) => {
    expect(processOpcode(testCase.input)).toEqual(testCase.part1Solution);
  });
});

// test('getFuelRecursive works', () => {
//   testCases.map((testCase: StringInStringOut) => {
//   });
// });
