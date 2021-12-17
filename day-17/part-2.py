#!/usr/bin/env python3

#135..155, y=-102..-78

def sim(xv, yv, x1, x2, y1, y2, p=False):
    x = 0
    y = 0
    while y >= y1:
        if p:
            print(x, y)
        x += xv
        if xv > 0:
            xv -= 1
        elif xv > 0:
            xv += 1
        y += yv
        yv -= 1
        if x1 <= x <= x2 and y1 <= y <= y2:
            return 1

    return 0

s = 0

for yv in range(-102, 103):
    for xv in range(156):
        s += sim(xv, yv, 135, 155, -102, -78)


print(s)
