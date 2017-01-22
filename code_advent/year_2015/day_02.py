""" http://adventofcode.com/2015/day/2 """


def box_lengths(dimensions):
    """Return list of dimension ints"""
    return sorted([int(i) for i in dimensions.split('x')])


def get_sides(dimensions):
    """Return sorted list of side areas"""
    lengths = box_lengths(dimensions)
    return sorted(lengths[i]*lengths[i-1] for i in range(3))


def get_box_paper(dimensions):
    """Return 2*each side plus 1 extra smallest side"""
    sides = get_sides(dimensions)
    return sum(2*s for s in sides) + sides[0]


def get_total_paper(boxes):
    """Get all paper needed for a list of boxes"""
    return sum(get_box_paper(b) for b in boxes)


def get_smallest_side_perimeter(dimensions):
    """Return the smallest perimeter of a box"""
    lengths = box_lengths(dimensions)
    return lengths[0]*2 + lengths[1]*2


def get_cubic_feet(dimensions):
    """Return cubic feet of a box"""
    res = 1
    for i in box_lengths(dimensions):
        res *= i
    return res


def get_box_ribbon(dimensions):
    """Return total ribbon needed for a box"""
    return get_smallest_side_perimeter(dimensions) + get_cubic_feet(dimensions)


def get_total_ribbon(boxes):
    """Return ribbon needed for list of boxes"""
    return sum(get_box_ribbon(b) for b in boxes)
