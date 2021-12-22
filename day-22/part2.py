#!/usr/bin/env python3

from collections import defaultdict
from pprint import pprint
from bitarray import bitarray
import sys

s = defaultdict(int)

def parse_range(x):
    i = 0
    while x[i] in "-0123456789":
        i += 1
    f = int(x[:i])
    i += 2
    j = i
    while x[j] in "-0123456789":
        j += 1
    s = int(x[i:j])
    if f < s:
        return f, s
    return s, f

def parse_line(line):
    if line[:2] == "on":
        val = 1
    if line[:3] == "off":
        val = 0
    _, x, y, z = line.split("=")
    return val, parse_range(x), parse_range(y), parse_range(z)

areas = []
def update(val, xs, ys, zs):
    global areas
    startx = lookupx[xs[0]]
    stopx = lookupx[xs[1]]
    starty = lookupy[ys[0]]
    stopy = lookupy[ys[1]]
    startz = lookupz[zs[0]]
    stopz = lookupz[zs[1]]

    for i in range(startx, stopx + 1):
        for j in range(starty, stopy + 1):
            # for k in range(startz, stopz + 1):
                areas[i][j][startz:stopz+1] = val

def add_around(s, v):
    # s.add(v - 1)
    s.add(v)
    s.add(v + 1)

space = []
xs = set()
ys = set()
zs = set()
for line in sys.stdin:
    v, (x0, x1), (y0, y1), (z0, z1) = parse_line(line)
    add_around(xs, x0)
    add_around(xs, x1)
    add_around(ys, y0)
    add_around(ys, y1)
    add_around(zs, z0)
    add_around(zs, z1)
    space.append((v, (x0, x1), (y0, y1), (z0, z1)))

xs = list(sorted(xs))
ys = list(sorted(ys))
zs = list(sorted(zs))

xs = list(sorted(xs))
ys = list(sorted(ys))
zs = list(sorted(zs))
lookupx = {v: i for i, v in enumerate(xs)}
lookupy = {v: i for i, v in enumerate(ys)}
lookupz = {v: i for i, v in enumerate(zs)}
# print((xs), (ys), (zs))

areas = [[bitarray('0') * len(zs) for _ in ys] for _ in xs]
for s in space:
    update(*s)

xdiff = [a - b for a, b in zip(xs[1:], xs)]
ydiff = [a - b for a, b in zip(ys[1:], ys)]
zdiff = [a - b for a, b in zip(zs[1:], zs)]


vals = []
total = 0
i = 0
for xx, plane in zip(xdiff, areas):
    print(i)
    i += 1
    for yy, row in zip(ydiff, plane):
        for zz, val in zip(zdiff, row[:-1]):
            if val:
                total += xx * yy * zz

print(total)





