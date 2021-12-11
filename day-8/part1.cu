count = 0
for (line in getline) {
	right = str_split(line, " | ")[1]
	segs = str_split(right, " ")
	for (seg in segs) {
		count += len(seg) == 2 || len(seg) == 3 || len(seg) == 4 || len(seg) == 7
	}
}
print(count)
