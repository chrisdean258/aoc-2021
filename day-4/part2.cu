#!/usr/bin/env copper


fn map(lst, fun) {
	rv = []
	for (val in lst) rv += [fun(val)]
	rv
}

fn nested_map(lol, fun) {
	for (i in range(len(lol))) {
		lol[i] = map(lol[i], fun)
	}
	lol
}


fn split(string, char) {
	rv = []
	cur = []
	for (ch in string) {
		if (ch != char) {
			cur += [ch]
		} else {
			rv += [cur]
			cur = []
		}
	}
	if(len(cur) > 0) rv += [cur]
	rv
}

fn int(chrs) {
	rv = 0
	for (chr in chrs) {
		ch = chr - '0' 
		rv = 10 * rv + ch
	}
	rv
}

fn is_bingo(board) {
	bingo = false
	for (i in range(5)) {
		vb = true;
		hb = true;
		for(j in range(5)) {
			if (board[i][j] != -1) hb = false;
			if (board[j][i] != -1) vb = false;
		}
		bingo |= (hb | vb) 
	}
	bingo
}

fn sum(list) {
	reduce(list, \0 + \1)
}

fn min(a, b) {
	if(a < b) a else b
}

numline = *getline()
nums = map(split(numline, ','), int)
losing_idx = 0


for (line in getline) {
	board = []
	for (_ in range(5)) {
		nums_str = split(*getline(), ' ')
		row = map(filter(nums_str, \len(\0) > 0), int)
		board += [row]
	}
	found_win = false
	for (i in range(len(nums))) {
		if(!found_win) {
			nested_map(board, \if(\0 == nums[i]) -1 else \0)
			if(is_bingo(board)) {
				found_win = true
				if (i > losing_idx) {
					nested_map(board, \if(\0 == -1) 0 else \0)
					losing_idx = i
					winning_score = sum(map(board, sum))
				}
			} 
		}
	}
}

print(winning_score* nums[losing_idx])
