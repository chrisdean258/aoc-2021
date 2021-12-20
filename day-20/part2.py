#!/usr/bin/env python3

import sys
from collections import defaultdict


def readblock(lst, si, sj):
    o = 0
    for i in range(si - 1, si + 2):
        for j in range(sj - 1, sj + 2):
            o = 2 * o + lst[i][j]
    return o

def unpack(img, default, pixels, li, hi, lj, hj):
    if default == 0:
        defval = pixels[0]
    else:
        defval = pixels[-1]
    new = defaultdict(lambda: defaultdict(lambda: defval))

    for i in range(li, hi + 1):
        for j in range(lj, hj + 1):
            val = readblock(img, i, j)
            new[i][j] = pixels[val]
    return new, defval




pixels = [0 if c == '.' else 1  for c in sys.stdin.readline().strip()]
sys.stdin.readline().strip()

img = defaultdict(lambda: defaultdict(int))

line_len = 0
rows = 0
for i, line in enumerate(sys.stdin):
    rows = i + 1
    line = line.strip()
    line_len = max(line_len, len(line))
    img[i] = defaultdict(int)
    for j, c in enumerate(line):
        img[i][j] = 0 if c == '.' else 1


default = 0
for i in range(50):
    img, default = unpack(img, default, pixels, -i - 5, rows + i + 5, -i - 5, line_len + i + 5)

s = 0
for v in img.values():
    s += sum(v.values())

print(s)

