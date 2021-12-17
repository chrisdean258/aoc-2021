#!/usr/bin/env python3

import sys

ipt = ""
taken = 0
def take(num):
    global taken
    global ipt
    rv = ipt[taken: taken+num]
    taken += num
    return int(rv, 2)

def advance():
    global taken
    while taken % 4 != 0:
        taken += 1

def parse_packet():
    global taken
    version = take(3)
    ID = take(3)
    if ID == 4:
        value = 0
        while True:
            read = take(5)
            if not read & 1 << 4:
                value = value << 4 | read
                break
            else:
                value = value << 4 | (read & 15)
        return (version, ID, value)
    subs = []
    length_type = take(1)
    if length_type == 0:
        bit_len = take(15)
        target = bit_len + taken
        while taken < target:
            subs.append(parse_packet())
    if length_type == 1:
        num_sub = take(11)
        for i in range(num_sub):
            subs.append(parse_packet())
    return (version, ID, subs)


def eval_(packets):
    if isinstance(packets[2], list):
        vals = [eval_(p) for p in packets[2]]
        if packets[1] == 0:
            return sum(vals)
        if packets[1] == 1:
            return reduce(lambda a, b: a * b, vals)
        if packets[1] == 2:
            return min(vals)
        if packets[1] == 3:
            return max(vals)
        if packets[1] == 5:
            return 1 * (vals[0] > vals[1])
        if packets[1] == 6:
            return 1 * (vals[0] < vals[1])
        if packets[1] == 7:
            return 1 * (vals[0] == vals[1])
    else:
        return packets[2]





table = {
    '0': '0000',
    '1': '0001',
    '2': '0010',
    '3': '0011',
    '4': '0100',
    '5': '0101',
    '6': '0110',
    '7': '0111',
    '8': '1000',
    '9': '1001',
    'A': '1010',
    'B': '1011',
    'C': '1100',
    'D': '1101',
    'E': '1110',
    'F': '1111',
}

ipt = sys.stdin.read()[:-1]
ipt = "".join(table[a] for a in ipt)
s = 0
# while taken < len(ipt):
packets = parse_packet()
advance()
s += eval_(packets)
print(s)

