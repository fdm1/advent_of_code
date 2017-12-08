from code_advent.year_2015 import day_05
import pytest


@pytest.mark.parametrize('string, result', (
    ('aei', True),
    ('xazegov', True),
    ('xxa', False),
))
def test_has_three_vowels(string, result):
    assert day_05.has_three_vowels(string) == result


@pytest.mark.parametrize('string, result', (
    ('abei', True),
    ('xazecdgov', True),
    ('xxa', False),
))
def test_has_bad_string(string, result):
    assert day_05.has_bad_string(string) == result


@pytest.mark.parametrize('string, result', (
    ('abbei', True),
    ('xazeecdgov', True),
    ('xya', False),
))
def test_has_double_letters(string, result):
    assert day_05.has_double_letters(string) == result


@pytest.mark.parametrize('string, result', (
    ('ugknbfddgicrmopn', True),
    ('aaa', True),
    ('jchzalrnumimnmhp', False),
    ('haegwjzuvuyypxyu', False),
    ('dvszwmarrgswjxmb', False),
))
def test_is_good_string(string, result):
    assert day_05.is_good_string(string) == result
