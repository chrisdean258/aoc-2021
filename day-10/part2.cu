fn first_illegal(string, idx) {
	global cheat
	first_char = string[idx]
	rv = [0, len(string)]
	closer = if (first_char == '{') '}' else if (first_char == '<') '>' else if (first_char == '[') ']' else ')'
	if(first_char == ']' || first_char == ')' || first_char == '>' || first_char == '}') {
		[1, idx]
	} else {
		idx++
		while (rv[0] == 0 && idx < len(string) && string[idx] != closer) {
			rv = first_illegal(string, idx)
			idx = rv[1]
		};
		if(idx >= len(string)) {
			cheat += [closer]
		}
		if(rv[0] == 1) rv else [0, idx + 1]
	}
}


scores = []
for (line in getline) {
	cheat = ['a']
	cheat = []
	rv = [0, 0]
	while(rv[0] == 0 && rv[1] < len(line)) {
		rv = first_illegal(line, rv[1])
	}
	if (rv[0] == 0) {
		score = 0
		for (val in cheat) {
			pt = if (val == '}') 3 else if (val == '>') 4 else if (val == ']') 2 else 1
			score = 5 * score + pt
		}
		scores += [score]
	}
}
sort(scores)
print(scores[len(scores) /2 ])
