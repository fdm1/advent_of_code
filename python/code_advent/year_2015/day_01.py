""" 2015 - Day 1: http://adventofcode.com/2015/day/1 """
from collections import Counter


def count_steps(input_str):
    """Count steps up/down ( '(' / ')' )"""
    counter = Counter(input_str)
    return counter['('] - counter[')']


def detect_basement(input_str):
    """Return the first time counter goes negative"""
    counter = Counter()
    for i in input_str:
        counter += Counter(i)
        if counter['('] < counter[')']:
            break
    return counter['('] + counter[')']
