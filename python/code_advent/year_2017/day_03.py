"""2017 day 3 http://adventofcode.com/2017/day/3"""
import sys


def ring_level(num):
    """Return the side lenth, level, and max value of a spiral ring of consecutive ints"""
    max_value = 1
    level = 0
    side_len = 1
    while max_value < num:
        level = level + 1
        side_len = (level * 2) + 1
        max_value = side_len + side_len * (side_len - 1)
    return side_len, level, max_value


def get_distance(num):
    """Return the Manhattan Distance for a number in a spiral of consecutive ints"""

    side_len, level, max_value = ring_level(num)
    while max_value > num:
        max_value = max_value - (side_len - 1)
    lateral = abs(num - (max_value + int(side_len / 2)))
    inwards = level
    return lateral + inwards


if __name__ == "__main__":

    print(get_distance(sys.argv[1]))
