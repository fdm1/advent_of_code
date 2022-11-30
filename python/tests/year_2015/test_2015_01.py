# pylint: disable=missing-docstring
from code_advent.year_2015 import day_01
import pytest


@pytest.mark.parametrize(
    "input_str, result",
    (
        ("(", 1),
        ("((", 2),
        ("(((", 3),
        (")", -1),
        ("))", -2),
        (")))", -3),
        ("(())", 0),
        ("))(((((", 3),
        (")())())", -3),
    ),
)
def test_count_steps(input_str, result):
    assert day_01.count_steps(input_str) == result


@pytest.mark.parametrize(
    "input_str, result",
    (
        (")", 1),
        (")))", 1),
        ("())", 3),
        ("()())", 5),
    ),
)
def test_detect_basement(input_str, result):
    assert day_01.detect_basement(input_str) == result
