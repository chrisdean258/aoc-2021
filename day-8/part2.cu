count = 0
for (line in getline) {
	lines = str_split(line, " | ")
	left = lines[0]

	masks = [0,0,0,0,0,0,0,0,0,0]
	segs = str_split(left, " ")
	for (seg in segs) {
		mask = 0
		for (char in seg) mask |= 1 << (char - 'a')
		if (len(seg) == 2) masks[1] = mask 
		if (len(seg) == 3) masks[7] = mask 
		if (len(seg) == 4) masks[4] = mask 
		if (len(seg) == 7) masks[8] = mask 
	}

	for (seg in segs) {
		mask = 0
		for (char in seg) mask |= 1 << (char - 'a')
		if (len(seg) == 6 && (mask | masks[7]) == masks[8]) masks[6] = mask
		else if (len(seg) == 6 && (mask | masks[4]) == masks[8]) masks[0] = mask
		else if (len(seg) == 6) masks[9] = mask

		if (len(seg) == 5 && ((mask | masks[1]) == mask)) masks[3] = mask
		else if (len(seg) == 5 && (mask | masks[4]) == masks[8]) masks[2] = mask
		else if (len(seg) == 5) masks[5] = mask
	}
	

	right = lines[1]
	segs = str_split(right, " ")
	lookup_table = map(range(128), fn(_) -1)
	for (i in range(len(masks))) {
		lookup_table[masks[i]] = i
	}
	val = 0
	for (seg in segs) {
		mask = 0
		for (char in seg) mask |= 1 << (char - 'a')
		val = val * 10 + lookup_table[mask]
	}
	count += val
}
print(count)
