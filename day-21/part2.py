#!/usr/bin/env python3

from collections import defaultdict as dd

scores = dd(int)
scores[(0,0,1,2)] = 1
wins = [0, 0]
player = 0

while scores:
    new_scores = dd(int)

    for (p1s, p2s, p1p, p2p), num_games in scores.items():
        for i in range(1, 4):
            for j in range(1, 4):
                for k in range(1, 4):
                    if player == 0:
                        p1np = (p1p + i + j + k - 1) % 10 + 1
                        p1ns = p1s + p1np
                        if p1ns >= 21:
                            wins[0] += num_games
                        else:
                            new_scores[(p1ns,p2s,p1np,p2p)] += num_games
                    if player == 1:
                        p2np = (p2p + i + j + k - 1) % 10 + 1
                        p2ns = p2s + p2np
                        if p2ns >= 21:
                            wins[1] += num_games
                        else:
                            new_scores[(p1s,p2ns,p1p,p2np)] += num_games
    player = 1 - player
    scores = new_scores
print(max(wins))

