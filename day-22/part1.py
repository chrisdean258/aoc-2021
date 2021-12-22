#!/usr/bin/env python3

from collections import defaultdict
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
    return range(max(f, -50), min(s + 1, 51))


for line in sys.stdin:
    if line[:2] == "on":
        val = 1
    if line[:3] == "off":
        val =   0
    _, x, y, z = line.split("=")
    for i in parse_range(x):
        for j in parse_range(y):
            for k in parse_range(z):
                s[(i, j, k)] = val

print(sum(s.values()))


