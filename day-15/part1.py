#!/usr/bin/env python3

import heapq
from collections import namedtuple
import sys


def insert_heap(heap, seen, risk, x, y, origrisk):
    if (x, y) in seen:
        return
    seen.add((x, y))
    if 0 <= x < len(risk[0]) and 0 <= y < len(risk):
        heapq.heappush(heap, (origrisk + risk[y][x], x, y))

seen = set()

inp = sys.stdin.readlines()
risk = []
for line in inp:
    risk.append([int(a) for a in line[:-1]])

heap = []
heapq.heappush(heap, (0, 0, 0))
seen.add((0, 0))

while heap:
    r, x, y = heapq.heappop(heap)
    if x == len(risk[0]) - 1 and y == len(risk) - 1:
        print(r)
        break
    insert_heap(heap, seen, risk, x + 1, y + 0, r)
    insert_heap(heap, seen, risk, x + 0, y + 1, r)
    insert_heap(heap, seen, risk, x - 1, y + 0, r)
    insert_heap(heap, seen, risk, x + 0, y - 1, r)


