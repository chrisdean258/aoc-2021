fn has9(board) {
	fold(board, \0 || fold(\1, \\0 || \1 >= 9, false), false)
}

fn increment(board, i, j) {
	if (i < len(board) && i >= 0 && j >= 0 && j < len(board[i])) {
		board[i][j] += 1
	}
}

board = []
N = 10


for (line in getline) {
	board += [map(line, \0 + 0 - '0')]
}

count = 0
l = 0
while(count < 100) {
	l++
	count = 0
	while(has9(board)) {
		for (i in range(N)) { for(j in range(N)) {
				if(board[i][j] >= 9) {
					board[i][j] = -2000
					count += 1
					increment(board, i + 1, j + 1)
					increment(board, i + 1, j + 0)
					increment(board, i + 1, j - 1)
					increment(board, i + 0, j + 1)
					increment(board, i + 0, j - 1)
					increment(board, i - 1, j + 1)
					increment(board, i - 1, j + 0)
					increment(board, i - 1, j - 1)
				}
			}
		}

	}
	for (i in range(N)) { for(j in range(N)) {
		board[i][j] += 1
		if (board[i][j] < 0) board[i][j] = 0
	}}
}

print(l)
