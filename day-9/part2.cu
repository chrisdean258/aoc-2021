
fn is_valid_idx(board, i, j) {
	i < len(board) && i >= 0 && j < len(board[i]) && j >= 0
}

fn calc_basin(board, i, j) {
	places = [[i, j]]
	idx = 0
	remove = 0
	while(idx < len(places)) {
		i = places[idx][0]
		j = places[idx][1]
		if (board[i][j] == '.') {
			remove++
		} else {

			if(is_valid_idx(board, i - 1, j) && board[i - 1][j] != '9' && board[i - 1][j] > board[i][j]) places += [[i - 1, j]]
			if(is_valid_idx(board, i + 1, j) && board[i + 1][j] != '9' && board[i + 1][j] > board[i][j]) places += [[i + 1, j]]
			if(is_valid_idx(board, i, j - 1) && board[i][j - 1] != '9' && board[i][j - 1] > board[i][j]) places += [[i, j - 1]]
			if(is_valid_idx(board, i, j + 1) && board[i][j + 1] != '9' && board[i][j + 1] > board[i][j]) places += [[i, j + 1]]
			board[i][j] = '.'
		}

		idx++
	}
	idx - remove
}


board = map(getline, \map(\0, \\0))
count = 0
basin_sizes = []
i = 0
j = 0
for (i in range(len(board))) {
	for (j in range(len(board[0]))) {
		if((i + 1 >= len(board)    || board[i][j] < board[i + 1][j]) &&
		   (j + 1 >= len(board[i]) || board[i][j] < board[i][j + 1]) &&
		   (i - 1 < 0             || board[i][j] < board[i - 1][j]) &&
		   (j - 1 < 0             || board[i][j] < board[i][j - 1])) {
			basin_sizes += [calc_basin(board, i, j)]
		}
	}
}
sort(basin_sizes)
print(basin_sizes)
print(basin_sizes[-1] * basin_sizes[-2] * basin_sizes[-3])
