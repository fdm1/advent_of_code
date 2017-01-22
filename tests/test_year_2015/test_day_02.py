from code_advent.year_2015 import day_02
import pytest


@pytest.mark.parametrize('dimensions, sides', (
    ('2x3x4', [6, 8, 12]),
    ('1x1x10', [1, 10, 10]),
    ))
def test_get_sides(dimensions, sides):
    assert day_02.get_sides(dimensions) == sides


@pytest.mark.parametrize('dimensions, box_paper', (
    ('2x3x4', 58),
    ('1x1x10', 43),
    ))
def test_get_box_paper(dimensions, box_paper):
    assert day_02.get_box_paper(dimensions) == box_paper


def test_get_total_paper():
    boxes = ['2x3x4', '1x1x10']
    assert day_02.get_total_paper(boxes) == 101
