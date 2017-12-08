"""2017 day 3 http://adventofcode.com/2017/day/3"""
import sys


def ring_level(num):
    """Return the side lenth, level, and max value of a spiral ring of consecutive ints"""
    max_value = 1
    level = 0
    side_len = 1
    while max_value < num:
        level = level + 1
        side_len = (level * 2) + 1
        max_value = side_len + side_len * (side_len - 1)
    return side_len, level, max_value


def get_distance(num):
    """Return the Manhattan Distance for a number in a spiral of consecutive ints"""

    side_len, level, max_value = ring_level(num)
    while max_value > num:
        max_value = max_value - (side_len - 1)
    lateral = abs(num - (max_value + int(side_len/2)))
    inwards = level
    return lateral + inwards
#
#
# def get_next_number(target):
#     level = 0
#     new_n = 0
#     previous_level = [[1], [1], [1], [1]]
#     while new_n < target:
#         level = level + 1
#         current_level = [[], [], [], []]
#         for side_i in range(4):
#             for i in range(level * 2):
#                 print(previous_level)
#                 print(current_level)
#                 print(f"level {level}, side {side_i}, spot {i}")
#                 # current level sum
#                 new_n = 0
#                 if current_level[side_i]:
#                     new_n = current_level[side_i][i-1]  # previous spot
#                     print(f"current_level - prev spot")
#                 elif current_level[side_i-1] and i <= 1:
#                     # current level previous corner    + spot before that corner
#                     new_n = new_n + current_level[side_i-1][-1] + current_level[side_i-1][-2]
#                     print(f"corner of current_lev same side + spot before that")
#                 if level > 0 and side_i == 3 and i >= (level * 2 - 2):
#                     new_n = new_n + current_level[0][0]
#                     print("last spot of level gets the first spot of the level")
#
#                 if i <= 1:
#                     # one in and to the left
#                     if level > 1:
#                         if side_i == 0 and i == 0:  # seed the new level
#                             new_n = new_n + previous_level[-1][-1] + previous_level[0][0]
#                             print(f"first spot of a new level gets last and first spots of prev level")
#                         if side_i == 0 and i == 1:
#                             new_n = new_n + previous_level[-1][-1] + previous_level[0][0] + previous_level[0][1]
#                             print(f"second spot of new level gets last and first two spots of new level ")
#                     else:
#                         new_n = new_n + previous_level[side_i][i]
#                         print(f"step5 - prev level to left {new_n}")
#                 elif i == level * 2:
#                     # last two of row underneath
#                     new_n = new_n + sum(previous_level[side_i][:-2])
#                     print(f"step6 - prev level last 2 {new_n}")
#                 elif i == 1: # corner gets just the previous level corner
#                     new_n = new_n + previous_level[side_i-1][-1]
#                     print(f"step7 - prev level corner {new_n}")
#
#                 if level > 1:
#                     if i > 1 and i < (level * 2 - 1):
#                         print("previous_level underneath")
#                         new_n = new_n + previous_level[side_i][i-2]
#                         new_n = new_n + previous_level[side_i][i-1]
#                     elif i == (level * 2 - 1):
#                         new_n = new_n + previous_level[side_i][-1]
#                     elif i == 1:
#                         new_n = new_n + previous_level[side_i-1][-1] + previous_level[side_i][0]
#
#
#
#                 current_level[side_i].append(new_n)
#
#                 if new_n > target:
#                     print (new_n)
#                     return new_n
#
#         # if new_n < target:
#         #     last_num = current_level[-1][-1] + current_level[0][0]
#         #     print(f"step8 - add last_num {last_num}")
#         #     current_level[-1].append(last_num)
#
#         previous_level = current_level
#         current_level = [[], [], [], []]
#
#         print(previous_level)
#
#     print (new_n)
#
#
if __name__ == '__main__':

    print(get_distance(sys.argv[1]))
