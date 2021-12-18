#!/usr/bin/env python3

import sys
from functools import reduce

def parse(s):
    nums = []
    depths = []
    cur_depth = -1
    for c in s:
        if c == '[':
            cur_depth += 1
        elif c == ']':
            cur_depth -= 1
        elif c in '0123456789':
            nums.append(int(c))
            depths.append(cur_depth)
    return nums, depths

def ssum(a1, a2):
    nums1, depths1 = a1
    nums2, depths2 = a2
    new = nums1 + nums2
    depths = depths1 + depths2
    depths = [d + 1 for d in depths]
    while True:
        ee = False
        ss = False
        while max(depths) > 3:
            explode(new, depths)
            ee = True
        if max(new) > 9:
            split(new, depths)
            ss = True
        if not ee and not ss:
            return new, depths

def explode(nums, depths):
    for i in range(len(nums)):
        if depths[i] > 3:
            assert(depths[i + 1] == depths[i]), f"{depths[i + 1]} != {depths[i]}"
            if i != 0:
                nums[i-1] += nums[i]
            if i < len(nums) - 2:
                nums[i+2] += nums[i+1]
            nums[i] = 0
            depths[i] -= 1
            del nums[i+1]
            del depths[i+1]
            return

def split(nums, depths):
    for i in range(len(nums)):
        if nums[i] > 9:
            depths[i] += 1
            depths.insert(i + 1, depths[i])
            nums.insert(i + 1, (nums[i] + 1) // 2)
            nums[i] //= 2
            return

def magnitude(nums, depths):
    nums = nums[:]
    depths = depths[:]
    i = 0
    while len(nums) > 1:
        if i < len(nums) - 1 and depths[i] == depths[i + 1]:
            nums[i] = 3 * nums[i] + 2*nums[i + 1]
            depths[i] -= 1
            del nums[i + 1]
            del depths[i + 1]
            i = 0
        else:
            i += 1
    return nums[0]


val = parse(sys.stdin.readline())
for line in sys.stdin:
    v2 = parse(line)
    val = ssum(val, v2)


print(magnitude(*val))
