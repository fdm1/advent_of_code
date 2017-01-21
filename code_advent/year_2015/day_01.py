""" 2015 - Day 1: http://adventofcode.com/2015/day/1 """
from collections import Counter


def count_steps(input_str):
    """Count steps up/down ( '(' / ')' )"""
    counter = Counter(input_str)
    return counter.get('(', 0) - counter.get(')', 0)
