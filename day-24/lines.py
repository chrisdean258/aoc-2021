#!/usr/bin/env python3

for i, line in enumerate(open(0)):
    if i % 18 in (4, 5, 15):
        print(line, end="")
