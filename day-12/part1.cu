fn streq(a, b) {
	eq = len(a) == len(b)
	if (eq) {
		for (i in range(len(a))) {
			eq = eq && (a[i] == b[i])
		}
	}
	eq
}

fn find(item) {
	idx = -1
	for(i in range(len(node_names))) {
		it = node_names[i]
		if (streq(it, item)) idx = i
	}
	idx
}

fn find_or_alloc(name) {
	global node_names
	global node_connections
	global node_visited
	idx = find(name)
	if (idx == -1) {
		idx = len(node_names)
		node_names += [name]
		a = [[-1]]
		node_connections += a
		node_connections[idx] = []
		node_visited += [false]
	}
	idx
}

fn dfs(start, target) {
	global node_connections
	global node_visited
	global node_names
	count = 0
	if (node_names[start][0] >= 'a' && node_names[start][0] <= 'z') {
		node_visited[start] = true
	}
	for (node in node_connections[start]) {
		if (node == target) {
			count += 1
		}
		else if (!node_visited[node]) {
			count += dfs(node, target)
		}
	}
	node_visited[start] = false
	count
}


node_names = [['a']]
node_names = []
node_connections = [[1]]
node_connections = []
node_visited = [true]
node_visited = []


for (line in getline) {
	lnodes = str_split(line, "-")
	lidx = find_or_alloc(lnodes[0])
	ridx = find_or_alloc(lnodes[1])
	node_connections[lidx] += [ridx]
	node_connections[ridx] += [lidx]
}

sidx = find("start")
eidx = find("end")

print(dfs(sidx, eidx))
