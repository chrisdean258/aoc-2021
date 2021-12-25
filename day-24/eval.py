#!/usr/bin/env python3
# from pprint import pprint
from sympy import symbols
consts = [(1, 15, 4), (1, 14, 16), (1, 11, 14), (26, -13, 3), (1, 14, 11), (1, 15, 13), (26, -7, 11), (1, 10, 7), (26, -12, 12), (1, 15, 15), (26, -16, 13), (26, -9, 1), (26, -8, 15), (26, -8, 4), ]  # noqa
consts1 = [1,  1,  1, 26,  1,  1, 26, 1, 26,  1, 26, 26, 26, 26, ]  # noqa
consts2 = [4, 16, 14,  3, 11, 13, 11, 7, 12, 15, 13,  1, 15,  4, ]  # noqa

syms = [symbols(f"w{i}", integer=True) for i in range(14)]
# syms[0] = 9
# syms[1] = 9
# syms[2] = 9
# syms[3] = 9
# syms[4] = 9
# syms[5] = 9
# syms[6] = 9
# syms[7] = 9
# syms[8] = 9
# syms[9] = 9
# syms[10] = 9
# syms[11] = 9
# syms[12] = 9
# syms[13] = 9

z = []
for i, w in enumerate(syms):
    if consts1[i] == 1:
        z.append(w + consts2[i])
    else:
        print(w - consts[i][1] - z.pop())

    # z //= consts1[i]
    # z *= 26
    # z += w + consts2[i]

print(z)
