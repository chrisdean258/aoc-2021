#!/usr/bin/env copper

fn srange(start, stop) \if (start < stop) start++
fn range(stop) srange(0, stop)
fn abs(a) if (a < 0)  -a else a

fn max(a, b) if (a > b) a else b
fn min(a, b) if (a < b) a else b

fn map(lst, fun) {
	rv = []
	for (val in lst) rv += [fun(val)]
	rv
}

fn sum(list) reduce(list, \0 + \1)

fn fold(list, fun, val) {
	for (v in list) {
		val = fun(val, v)
	}
	val
}

fn reduce(list, fun)  {
	rv = list[0]
	for (i in srange(1, len(list))) {
		rv = fun(rv, list[i])
	}
	rv
}

fn parse_line(line) {
	i = 0
	p1x = 0
	while(line[i] >= '0' & line[i] <= '9') {
		p1x = p1x * 10 + line[i++] - '0'
	}
	i++
	p1y = 0
	while(line[i] >= '0' & line[i] <= '9') {
		p1y = p1y * 10 + line[i++] - '0'
	}
	i += 4
	p2x = 0
	while(line[i] >= '0' & line[i] <= '9') {
		p2x = p2x * 10 + line[i++] - '0'
	}
	i++
	p2y = 0
	while(i < len(line)) {
		p2y = p2y * 10 + line[i++] - '0'
	};
	[[p1x, p1y],[p2x,p2y]]
}


points = []
for (line in getline) {
	point = parse_line(line)
	points += [point]
}
maxx = fold(points, \max(max(\1[0][0], \1[1][0]), \0), 0) + 1
maxy = fold(points, \max(max(\1[1][0], \1[1][1]), \0), 0) + 1
board = map(range(maxx), fn(_) map(range(maxy), fn(_) 0))

for (point in points) {
	
	incx = if(point[0][0] == point[1][0]) 0 else if (point[0][0] < point[1][0]) 1 else -1
	incy = if(point[0][1] == point[1][1]) 0 else if (point[0][1] < point[1][1]) 1 else -1
	x = point[0][0]
	y = point[0][1]
	while(x != point[1][0] | y != point[1][1]) {
		board[x][y] += 1
		x += incx
		y += incy
	}
		board[x][y] += 1
}

val = 0
for (l in board) for (i in l) val += i > 1

print(val)
