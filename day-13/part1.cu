maxes = map(str_split(*getline(), ","), int)

maxx = maxes[0]
maxy = maxes[1]

board = map(range(maxy + 1), fn(a) map(range(maxx + 1), fn(b) 0))

getline()

brk = false

while(len(line = *getline()) > 0) {
	pt = map(str_split(line, ","), int)
	ptx = pt[0]
	pty = pt[1]
	board[pty][ptx] = 1
}

# map(board, \{map(\0, prints) print()})
# print()

for(line in getline) {
	inst = str_split(line, "=")
	if(inst[0][-1] == 'y') {
		val = int(inst[1])
		for (j in range(val + 1, maxy + 1)) {
			for(k in range(maxx + 1)) {
				board[2*val - j][k] |= board[j][k]
			}
		}
		maxy = val
	}
	else if(inst[0][-1] == 'x') {
		val = int(inst[1])
		for (j in range(val + 1, maxx + 1)) {
			for(k in range(maxy + 1)) {
				board[k][2*val - j] |= board[k][j]
			}
		}
		maxx = val
	}
}


count = 0
for (p in range(maxy + 1)) {
	for(v in range(maxx + 1)) {
		prints(board[p][v])
	}
	print()
}

