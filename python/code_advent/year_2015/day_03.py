""" http://adventofcode.com/2015/day/3 """
from collections import namedtuple

Point = namedtuple('Point', ['x', 'y'])


def move(point, direction):
    """Return new position based on direction"""
    if direction == '^':
        return Point(point.x, point.y + 1)
    if direction == 'v':
        return Point(point.x, point.y - 1)
    if direction == '<':
        return Point(point.x - 1, point.y)
    return Point(point.x + 1, point.y)


def get_house_set(directions):
    """Return list of houses touched in series of directions"""
    position = Point(0, 0)
    houses = [position]
    for direction in directions:
        position = move(position, direction)
        houses.append(position)
    return houses


def get_houses(directions):
    """Get set length from list of houses"""
    return len(set(get_house_set(directions)))


def get_split_houses(directions):
    """Same as original, but two drivers alternating directions"""
    # Subtract 1 since they both start at the same house
    return len(set(get_house_set(directions[::2]) + get_house_set(directions[1::2])))
