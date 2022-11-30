# pylint: disable=missing-docstring
from code_advent.year_2015 import day_03
import pytest


@pytest.mark.parametrize(
    "direction, result",
    (
        ("^", day_03.Point(0, 1)),
        ("v", day_03.Point(0, -1)),
        ("<", day_03.Point(-1, 0)),
        (">", day_03.Point(1, 0)),
    ),
)
def test_move(direction, result):
    assert day_03.move(day_03.Point(0, 0), direction) == result


@pytest.mark.parametrize(
    "directions, count",
    (
        ("^", 2),
        ("^>v<", 4),
        ("^v^v^v^v^v", 2),
    ),
)
def test_get_houses(directions, count):
    assert day_03.get_houses(directions) == count


@pytest.mark.parametrize(
    "directions, count",
    (
        ("^v", 3),
        ("^>v<", 3),
        ("^>v<<v<", 6),
        ("^v^v^v^v^v", 11),
    ),
)
def test_get_split_houses(directions, count):
    assert day_03.get_split_houses(directions) == count
