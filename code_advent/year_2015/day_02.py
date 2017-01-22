""" http://adventofcode.com/2015/day/2 """


def get_sides(dimensions):
    """Return sorted list of side areas"""
    lengths = [int(i) for i in dimensions.split('x')]
    return sorted(lengths[i]*lengths[i-1] for i in range(3))


def get_box_paper(dimensions):
    """Return 2*each side plus 1 extra smallest side"""
    sides = get_sides(dimensions)
    return sum(2*s for s in sides) + sides[0]


def get_total_paper(boxes):
    return sum(get_box_paper(b) for b in boxes)
