""" http://adventofcode.com/2015/day/5 """
from string import ascii_lowercase

VOWELS = ['a', 'e', 'i', 'o', 'u']
BAD_STRINGS = ['ab', 'cd', 'pq', 'xy']
DOUBLE_LETTERS = [i*2 for i in ascii_lowercase]


def is_good_string(string):
    """Test all the rules"""
    return (has_three_vowels(string) and
            not has_bad_string(string) and
            has_double_letters(string))


def has_three_vowels(string):
    """Test if a string has at least 3 vowels"""
    return len([s for s in string if s in VOWELS]) >= 3


def check_for_contents(string, string_dict):
    """Iterate through string dict to check contents in other string"""
    for snippet in string_dict:
        if snippet in string:
            return True
    return False


def has_bad_string(string):
    """Tests if a string contains forbidden text"""
    return check_for_contents(string, BAD_STRINGS)


def has_double_letters(string):
    """Tests if a string contains forbidden text"""
    return check_for_contents(string, DOUBLE_LETTERS)
