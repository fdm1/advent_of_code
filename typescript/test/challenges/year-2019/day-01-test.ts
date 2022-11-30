import { TestCase } from '@test/test-types';
import { getFuel, getFuelRecursive } from '../../../src/challenges/year-2019/day-01';

test('getFuel works', () => {
  const testCases: TestCase[] = [
    { input: 12, solution: 2 },
    { input: 14, solution: 2 },
    { input: 1969, solution: 654 },
    { input: 100756, solution: 33583 },
  ];

  testCases.map((testCase: TestCase) => {
    expect(getFuel(testCase.input)).toEqual(testCase.solution);
  });
});

test('getFuelRecursive works', () => {
  const testCases: TestCase[] = [
    { input: 12, solution: 2 },
    { input: 14, solution: 2 },
    { input: 1969, solution: 966 },
    { input: 100756, solution: 50346 },
  ];

  testCases.map((testCase: TestCase) => {
    expect(getFuelRecursive(testCase.input)).toEqual(testCase.solution);
  });
});
