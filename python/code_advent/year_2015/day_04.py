""" http://adventofcode.com/2015/day/4 """
from hashlib import md5


def validate_hash(input_str, num_zeros):
    """Check if hex md5 starts with '00000'"""
    if md5(input_str.encode('utf-8')).hexdigest().startswith('0'*num_zeros):
        return input_str


def find_min_suffix(prefix, num_zeros, suffix=0):
    """Find min string that is prefixINT and hash starts with 00000"""
    result = None
    while not result:
        suffix += 1
        result = validate_hash('%s%s' % (prefix, suffix), num_zeros)
    return suffix
