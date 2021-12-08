fn range(start, stop) {
	\if (start < stop) start++
}

fn map(lst, fun) {
	rv = []
	for (val in lst) rv += [fun(val)]
	rv
}

fn reduce(list, fun)  {
	rv = list[0]
	for (i in range(1, len(list))) {
		rv = fun(rv, list[i])
	}
	rv
}

fn filter(list, predicate) {
	rv = []
	for (val in list) {
		if (predicate(val)) {
			rv += [val]
		}
	}
	rv
}

fn most_common(strs, idx) {
	rv = [0, 0]
	map(strs, \(rv[\0[idx] == '1'] += 1))
	if (rv[0] > rv[1]) '0' else '1'
}


strs_o2 = []
strs_co2 = []
for (line in getline) {
	strs_o2 += [line]
	strs_co2 += [line]
}


bit_idx = 0
while(len(strs_o2) > 1) {
	common = most_common(strs_o2, bit_idx)
	strs_o2 = filter(strs_o2, \(\0[bit_idx] == common))
	bit_idx++
}

bit_idx = 0
while(len(strs_co2) > 1) {
	common = most_common(strs_co2, bit_idx)
	strs_co2 = filter(strs_co2, \(\0[bit_idx] != common))
	bit_idx++
}

o2 = reduce(map(strs_o2[0], \0 + 0 - '0'), \(\0) * 2  + \1)
co2 = reduce(map(strs_co2[0], \0 + 0 - '0'), \(\0) * 2  + \1)

print(o2 * co2)



# bits = map(counts, \if(\0 < num_lines / 2) 1 else 0)
# nbits = map(bits, \(1 - \0))

# epsilon = reduce(bits, (\0 * 2 + \1))
# gamma = reduce(nbits, (\0 * 2 + \1))

# print(gamma * epsilon)
