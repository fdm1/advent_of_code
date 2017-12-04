"""2017 day 2 http://adventofcode.com/2017/day/2"""
import sys


def checksum(sheet_file, even=False):
    """Return the sum of each row's max - min"""
    result = 0
    with open(sheet_file) as f:
        sheet_list = f.readlines()

        for row in sheet_list:
            int_row = [int(i) for i in row.split('\t')]
            result = result + (max(int_row) - min(int_row))
    return result


if __name__ == '__main__':
    even = len(sys.argv) > 2 and sys.argv[2].lower() == 'even'
    print(checksum(sheet_file=sys.argv[1], even=even))
