fn replace(list, replacements) {
	i = 0
	reps = [
		[ 0, 0 ]
	]
	reps = []
	while(i < len(list) - 1) {
		any_rep = false
		for(rep in replacements) {
			if (i < len(list) - 1 && list[i] == rep[0][0] && list[i + 1] == rep[0][1]) {
				any_rep = true
				reps += [
					[i+1, rep[1][0]]
				]
				i += 1
			}
		}
		if(!any_rep) i++
	}
	origlist = map(list, \0)
	list += map(reps, fn(_) -1)
	from_idx = 0
	to_idx = 0
	rep_idx = 0
	while (to_idx < len(list)) {
		while((rep_idx < len(reps) && from_idx < len(origlist) && to_idx < rep_idx + reps[rep_idx][0]) || (rep_idx >= len(reps) && to_idx < len(list))) {
			list[to_idx++] = origlist[from_idx++]
		}
		if(rep_idx < len(reps) && to_idx < len(list)) list[to_idx++] = reps[rep_idx++][1]
	}
}


str = map(*getline(), \0 - 'A' - 0)

replacements = []

getline()
for (line in getline) {
	reps = str_split(line, " -> ")
	lhs = map(reps[0], \0 - 'A' - 0)
	rhs = map(reps[1], \0 - 'A' - 0)
	replacements += [[lhs, rhs]]

}

for (i  in range(10)) {
	replace(str, replacements)
	print(i + 1, " ", len(str))
	if (i < 5)
	print(str)
}

counts = map(range(26), fn(_) -1)
for (c in str) { if (counts[c] > 0) counts[c] += 1 else counts[c] = 1 }

counts = filter(counts, \0 != -1)


print(reduce(counts, max) - reduce(counts, min))
