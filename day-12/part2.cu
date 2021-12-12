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
	global doubled
	global sidx
	count = 0
	if (node_names[start][0] >= 'a' && node_names[start][0] <= 'z') {
		if (node_visited[start]) doubled = start;
		node_visited[start] = true
	}
	for (node in node_connections[start]) {
		if (node == target) {
			count += 1
		}
		else if (!node_visited[node] || (doubled == -1)) {
			count += dfs(node, target)
		}
	}
	if (doubled == start) {
		doubled = -1;
	} else {
		node_visited[start] = false
	}
	count
}


node_names = [['a']]
node_names = []
node_connections = [[1]]
node_connections = []
node_visited = [true]
node_visited = []
doubled = -1


for (line in getline) {
	lnodes = str_split(line, "-")
	lidx = find_or_alloc(lnodes[0])
	ridx = find_or_alloc(lnodes[1])
	if (!streq(lnodes[1], "start"))
	node_connections[lidx] += [ridx]
	if (!streq(lnodes[0], "start"))
	node_connections[ridx] += [lidx]
}

sidx = find("start")
eidx = find("end")

print(dfs(sidx, eidx))
