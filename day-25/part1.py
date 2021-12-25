#!/usr/bin/env python3

import fileinput


def nrange(stop):
    for i in range(stop):
        yield i, (i + 1) % stop


board = []
for line in fileinput.input():
    board.append(list(line[:-1]))


def pboard(board):
    print("\n".join("".join(i) for i in board))
    print()


moved = True
iterations = 0
pboard(board)
while moved:
    iterations += 1
    moved = False
    for i in range(len(board)):
        for j, nj in nrange(len(board[i])):
            if board[i][j] == ">" and board[i][nj] == '.':
                board[i][j] = "x"
                board[i][nj] = "y"
                moved = True
    for i in range(len(board)):
        for j in range(len(board[i])):
            if board[i][j] == "x":
                board[i][j] = "."
            if board[i][j] == "y":
                board[i][j] = ">"
    for i, ni in nrange(len(board)):
        for j in range(len(board[i])):
            if board[i][j] == "v" and board[ni][j] == '.':
                board[ni][j] = "y"
                board[i][j] = "x"
                moved = True
    for i in range(len(board)):
        for j in range(len(board[i])):
            if board[i][j] == "x":
                board[i][j] = "."
            if board[i][j] == "y":
                board[i][j] = "v"
    # pboard(board)
    print(iterations)

print(iterations)
