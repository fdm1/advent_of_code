# pylint: disable=missing-docstring
from code_advent.year_2015 import day_04
import pytest


@pytest.mark.parametrize(
    "input_str, num_zeros, result",
    (
        ("pqrstuv1048970", 5, "pqrstuv1048970"),
        ("abcdef609041", 5, None),
    ),
)
def test_validate_hash(input_str, num_zeros, result):
    assert day_04.validate_hash(input_str, num_zeros) == result


@pytest.mark.skip(reason="this is slow and the challenge is complete")
@pytest.mark.parametrize(
    "prefix, num_zeros, result",
    (
        ("pqrstuv", 5, 1048970),
        ("abcdef", 5, 609043),
    ),
)
def test_find_min_suffix(prefix, num_zeros, result):
    assert day_04.find_min_suffix(prefix, num_zeros) == result
