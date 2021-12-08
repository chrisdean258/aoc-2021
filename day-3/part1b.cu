fn map(lst, fun) {
	rv = []
	for (val in lst) rv += [fun(val)]
	rv
}

fn add_bits(list, str) {
	i = 0
	for (c in str) {
		list[i] += (str[i] == '1')
		i++
	}
}

fn reduce(list, fun)  {
	i = 1
	rv = list[0]
	while (i < len(list)) {
		rv = fun(rv, list[i++])
	}
	rv
}

line = *getline()

l = len(line)
counts = []
num_lines = 1

while(l-- > 0) {
	counts += [0]
}

add_bits(counts, line)
for (line in getline) {
	add_bits(counts, line)
	num_lines++
}


bits = map(counts, \if(\0 < num_lines / 2) 1 else 0)
nbits = map(bits, \(1 - \0))

epsilon = reduce(bits, (\0 * 2 + \1))
gamma = reduce(nbits, (\0 * 2 + \1))

print(gamma * epsilon)
