#!/usr/bin/env python3

import sys
import numpy as np
from itertools import combinations

i = np.array([[1,0,0],[0,1,0],[0,0,1]])
r = np.array([[1,0,0],[0,0,-1],[0,1,0]])
t = np.array([[0,0,1],[0,1,0],[-1,0,0]])

rots = [
    i,         r,         r@r,         r@r@r,
    t,         t@r,       t@r@r,       t@r@r@r,
    t@t,       t@t@r,     t@t@r@r,     t@t@r@r@r,
    t@t@t,     t@t@t@r,   t@t@t@r@r,   t@t@t@r@r@r,
    r@t,       r@t@r,     r@t@r@r,     r@t@r@r@r,
    r@t@t@t,   r@t@t@t@r, r@t@t@t@r@r, r@t@t@t@r@r@r,
]


def rot(num, points):
    return [rots[num] @ p for p in points]


def intersect(points1, points2):
    for i in range(24):
        ps = rot(i, points2)
        offset = intersect_no_rot(points2, points1)
        if offset:
            return offset
    return 0

def intersect_no_rot(points1, points2):
    sp1 = set((x, y, z) for x,y,z in points1)
    for point in points1:
        xoff = point[0] - points2[0][0]
        yoff = point[1] - points2[0][1]
        zoff = point[2] - points2[0][2]
        sp2o = set((x+xoff, y+yoff, z+zoff) for x,y,z in points2)
        inter = sp1 & sp2o
        if len(inter) >= 12:
            return len(inter)
    return 0

scanners = []
for line in sys.stdin:
    line = line.strip()
    if not line:
        continue
    if line.startswith("---"):
        scanners.append([])
    else:
        scanners[-1].append(eval(f"np.array(({line}))"))

total = sum(len(s) for s in scanners)
# for s1, s2 in combinations(scanners, 2):
    # total -= intersect(s1, s2)
intersect(scanners[0], scanners[1])

print(total)



