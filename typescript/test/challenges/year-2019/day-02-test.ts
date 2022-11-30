import { TestCase } from '@test/test-types';
import { processOpcode } from '../../../src/challenges/year-2019/day-02';

describe('.processOpcode', () => {
  test('without noun and verb', () => {
    const testCases: TestCase[] = [
      { input: [1, 0, 0, 0, 99], solution: [2, 0, 0, 0, 99] },
      { input: [2, 3, 0, 3, 99], solution: [2, 3, 0, 6, 99] },
      { input: [2, 4, 4, 5, 99, 0], solution: [2, 4, 4, 5, 99, 9801] },
      { input: [1, 1, 1, 4, 99, 5, 6, 0, 99], solution: [30, 1, 1, 4, 2, 5, 6, 0, 99] },
    ];

    testCases.map((testCase: TestCase) => {
      expect(processOpcode({ input: testCase.input })).toEqual(testCase.solution);
    });
  });

  test('with noun and verb', () => {
    const testCases: TestCase[] = [
      { input: [1, 0, 0, 0, 99], solution: [3, 1, 2, 0, 99] },
      { input: [2, 3, 0, 3, 99], solution: [2, 1, 2, 2, 99] },
      { input: [2, 4, 4, 5, 99, 0], solution: [2, 1, 2, 5, 99, 2] },
      { input: [2, 1, 1, 4, 99, 5, 6, 0, 99], solution: [30, 1, 2, 4, 2, 5, 6, 0, 99] },
    ];

    testCases.map((testCase: TestCase) => {
      expect(processOpcode({ input: testCase.input, noun: 1, verb: 2 })).toEqual(testCase.solution);
    });
  });

  test('with unknown command', () => {
    let message = '';
    const badCommand = 5;
    try {
      processOpcode({ input: [badCommand] });
    } catch (error) {
      message = error.message;
    }

    expect(message).toBe(`unknown command ${badCommand}`);
  });
});
