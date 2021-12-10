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

fish = [0,0,0,0,0,0,0,0,0]

input = map(split(*getline(), ','), int)
for (f in input) fish[f] += 1

for (j in range(80)) {
	spawning = fish[0];
	for(i in range(8)) fish[i] = fish[i+1]
	fish[6] += spawning
	fish[8] = spawning
}

print(sum(fish))

