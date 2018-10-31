# pylint: disable=missing-docstring
import pytest

from code_advent.year_2017 import day_03


@pytest.mark.parametrize('num,result', (
    (4, (3, 1, 9)),
    (10, (5, 2, 25)),
    (50, (9, 4, 81)),
))
def test_ring_level(num, result):
    assert day_03.ring_level(num) == result


@pytest.mark.parametrize('num,result', (
    (4, 1),
    (10, 3),
    (50, 7),
))
def test_get_distance(num, result):
    assert day_03.get_distance(num) == result
