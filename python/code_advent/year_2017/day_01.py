"""2017 day 1 http://adventofcode.com/2017/day/1"""
import sys


def filter_for_neighbors(string_num):
    """Filter for characters who's previous character is the same"""
    return [string_num[i] for i in range(len(string_num))
            if string_num[i] == string_num[i-1]]


def filter_half_way(string_num):
    """Filter for characters who match half way around the list"""
    strlen = len(string_num)
    return [string_num[i] for i in range(strlen)
            if string_num[i] == string_num[int(i-strlen/2)]]


def get_sum(string_num, func=None):
    """
    Reduce a string into the sum of characters with a matching neighbor
    If `func` is anything at all, use the half-way filtering
    """
    func = filter_for_neighbors if func is None else filter_half_way

    return sum([int(i) for i in func(string_num)])


if __name__ == '__main__':
    if len(sys.argv) == 2:
        func_arg, num = (None, sys.argv[1])
    else:
        func_arg, num = sys.argv[1], sys.argv[2]

    print(get_sum(func=func_arg, string_num=num))
