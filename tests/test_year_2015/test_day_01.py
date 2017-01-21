from code_advent.year_2015 import day_01
import pytest


@pytest.mark.parametrize('input_str, result', (
    ('(', 1),
    ('((', 2),
    ('(((', 3),
    (')', -1),
    ('))', -2),
    (')))', -3),
    ('(())', 0),
    ('))(((((', 3),
    (')())())', -3),
    ))
def test_steps(input_str, result):
    assert day_01.count_steps(input_str) == result
