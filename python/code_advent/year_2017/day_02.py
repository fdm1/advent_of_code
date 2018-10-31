"""2017 day 2 http://adventofcode.com/2017/day/2"""
import sys


def checksum_min_max(sheet_file):
    """Return the sum of each row's max - min"""
    result = 0
    with open(sheet_file) as f:
        sheet_list = f.readlines()

        for row in sheet_list:
            int_row = [int(i) for i in row.split('\t')]
            result = result + (max(int_row) - min(int_row))

    return result


# pylint: disable=inconsistent-return-statements
def row_divisibles(row):
    """Find two items in a list of integers that are divisible"""
    row = list(row)
    row_max = max(row)
    for i in sorted(row):
        for multiplier in range(2, int(row_max/i) + 1):
            if i * multiplier in row:
                return (i, i * multiplier)


def checksum_even_divisible(sheet_file):
    """Return the sum of each row's max / min for the two digits that are evenly divisible"""
    result = 0
    with open(sheet_file) as f:
        sheet_list = f.readlines()

        for row in sheet_list:
            divisibles = row_divisibles(int(i) for i in row.split('\t'))
            if divisibles:
                result = result + (divisibles[1] / divisibles[0])
    return int(result)


if __name__ == '__main__':
    even = len(sys.argv) > 2 and sys.argv[2].lower() == 'even'

    if not even:
        print(checksum_min_max(sheet_file=sys.argv[1]))
    else:
        print(checksum_even_divisible(sheet_file=sys.argv[1]))
