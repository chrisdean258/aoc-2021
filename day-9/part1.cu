board = map(getline, \0)

count = 0
for (i in range(len(board))) {
	for (j in range(len(board[0]))) {
		if((i + 1 >= len(board)    || board[i][j] < board[i + 1][j]) &&
		   (j + 1 >= len(board[i]) || board[i][j] < board[i][j + 1]) &&
		   (i - 1 < 0             || board[i][j] < board[i - 1][j]) &&
		   (j - 1 < 0             || board[i][j] < board[i][j - 1])) {
			count += board[i][j] + 1 - '0'
		}
	}
}
print(count)
