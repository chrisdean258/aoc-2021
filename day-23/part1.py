#!/usr/bin/env python3

import sys
# from pprint import pprint
from heapq import heappush as push, heappop as pop


def get_path(f, t):
    need_clear = []
    cost = 2
    while f >= 11:
        f -= 4
        cost += 1
        need_clear.append(f)
    point = f - (5.5)
    if t < point:
        point = int(point)
        while point > t:
            need_clear.append(point)
            point -= 1
            cost += 2
    else:
        point = int(point) + 1
        while point < t:
            need_clear.append(point)
            point += 1
            cost += 2
    if t == 0 or t == 6:
        cost -= 1
    return cost, need_clear


paths = {}
for i in range(7):
    for j in range(7, 13):
        paths[(j, i)] = get_path(j, i)

# pprint(paths)


class dq:
    def __init__(self):
        self.values = {}
        self.keys = []
        self.value_to_idx = {}

    def pop(self):
        idx = self.keys[0]
        while len(self.values[idx]) == 0:
            pop(self.keys)
            idx = self.keys[0]
        rv = self.values[idx].pop()
        del self.value_to_idx[rv]
        return idx, rv

    def __setitem__(self, key, val):
        if val in self.value_to_idx:
            if self.value_to_idx[val] < key:
                return
            self.values[self.value_to_idx[val]].remove(val)

        self.value_to_idx[val] = key
        if key in self.values:
            self.values[key].add(val)
        else:
            push(self.keys, key)
            self.values.setdefault(key, set()).add(val)

    def __len__(self):
        return len(self.value_to_idx)


state = [a for a in sys.stdin.read() if a in "ABCD"]
states = dq()
states[0] = tuple([None] * 7 + state)
costs = {}
mscore = 0


COST = {"A": 1, "B": 10, "C": 100, "D": 1000, None: 0}
COL = {"A": 0, "B": 1, "C": 2, "D": 3}


def pstate(state):
    print("#############")
    print("#" + "".join(f"{q or ' '}" for q in state[:2]), end="")
    print(" " + " ".join(f"{q or ' '}" for q in state[2:5]), end="")
    print(" " + "".join(f"{q or ' '}" for q in state[5:7]) + "#")
    print('###' + "#".join(f"{q or ' '}" for q in state[7:11]) + '###')
    print('  #' + "#".join(f"{q or ' '}" for q in state[12:]) + '#')
    print("  #########")


def pstate2(state):
    print("".join(f"{q or '-':3}" for q in state))


def do_transitions(state):
    for (f, t), (c, clear) in paths.items():
        if (state[f] is None and state[t] is not None):
            if set(state[p] for p in clear) | {None} == {None}:
                if COL[state[t]] == (f - 7) % 4:
                    # print(state[t], "->", f)
                    cost = COST[state[f]] + COST[state[t]]
                    st = list(state)
                    st[f], st[t] = st[t], st[f]
                    # print(f, t, c, clear)
                    yield cost * c, tuple(st)
        if (state[f] is not None and state[t] is None):
            if set(state[p] for p in clear) | {None} == {None}:
                cost = COST[state[f]] + COST[state[t]]
                st = list(state)
                st[f], st[t] = st[t], st[f]
                # print(f, t, c, clear)
                yield cost * c, tuple(st)
    # print("#" * 45)
    # pstate(state)
    # print("-" * 45)
    # for s in rv:
        # pstate(s[1])


def is_finished(state):
    print(state[7:15])
    return state[7:15] == list("ABCDABCD")


def estimate(state):
    # print(state)
    cost = 0
    cost += 0 if state[7] == "A" else 1
    cost += 0 if state[8] == "B" else 10
    cost += 0 if state[9] == "C" else 100
    cost += 0 if state[10] == "D" else 1000
    cost += 0 if state[11] == "A" else 2
    cost += 0 if state[12] == "B" else 20
    cost += 0 if state[13] == "C" else 200
    cost += 0 if state[14] == "D" else 2000
    return cost


while states:
    cost, st = states.pop()
    # print(cost)
    # print(len(states))
    if st in costs:
        continue
    costs[st] = cost
    # print("--", len(costs)) print(st)
    for c, t in do_transitions(st):
        if is_finished(t):
            pstate(st)
            pstate(t)
            print(c)
            sys.exit(0)
        c += cost
        # c += estimate(t)
        if t not in costs:
            states[c] = t
