# pylint: disable=missing-docstring
from code_advent.year_2017 import day_01
import pytest


@pytest.mark.parametrize(
    "num,func_arg,expected_sum",
    (
        ("1234", None, 0),
        ("1122", None, 3),
        ("12341", None, 1),
        ("12331", None, 4),
        ("1212", "half", 6),
        ("1221", "half", 0),
        ("123425", "half", 4),
        ("123123", "half", 12),
        ("12131415", "half", 4),
    ),
)
def test_get_sum(num, func_arg, expected_sum):
    assert day_01.get_sum(string_num=num, func=func_arg) == expected_sum
