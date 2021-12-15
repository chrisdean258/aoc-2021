transactions = map(range(26), fn(_) map(range(26), fn(_)  map(range(26), fn(_) 0) ) )

str = map(*getline(), \0 - 'A' - 0)

replacements = []

getline()
for (line in getline) {
	reps = str_split(line, " -> ")
	lhs = map(reps[0], \0 - 'A' - 0)
	rhs = map(reps[1], \0 - 'A' - 0)
	replacements += [[lhs, rhs]]
}



for(rep in replacements) {
	transactions[rep[0][0]][rep[0][1]][rep[1][0]] += 1
	transactions[rep[0][0]][rep[0][1]][rep[0][0]] += 1
	transactions[rep[0][0]][rep[0][1]][rep[0][1]] += 1
}


for(i in range(39)) {
	new_trans = map(range(26), fn(_) map(range(26), fn(_) map(range(26), fn(_) 0) ) )
	for(rep in replacements) {
		for (j in range(26)) {
			new_trans[rep[0][0]][rep[0][1]][j] =
				transactions[rep[0][0]][rep[1][0]][j] +
				transactions[rep[1][0]][rep[0][1]][j]
		}
		new_trans[rep[0][0]][rep[0][1]][rep[1][0]] -= 1
	}
	transactions = new_trans
}

counts = map(range(26), fn(_) 0)
for (i in range(len(str) - 1)) {
		# print("checking ", str[i], " ", str[i+1])
	for (j in range(26)) {
		counts[j] += transactions[str[i]][str[i+1]][j]
	}
		# print(counts)
}

for (k in range(1, len(str) - 1)) {
	counts[str[k]] -= 1
}

counts = filter(counts, \0 != 0)

print(reduce(counts, max) - reduce(counts, min))

