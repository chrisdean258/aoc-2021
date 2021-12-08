fn bits_to_num(bits) {
	rv = 0 i = 0
	while(i < len(bits)) {
		rv = rv * 2 + bits[i++]
	}
	rv
}

fn map(lst, fun) {
	i = 0
	rv = []
	while(i < len(lst)) {
		rv += [fun(lst[i++])]
	}
	rv
}

fn add_bits(list, str) {
	i = 0
	while(i < len(str) - 1) {
		list[i] += (str[i] == '1')
		i++
	}
}

line = *getline()

l = len(line) - 1
counts = []
num_lines = 1

while(l-- > 0) {
	counts += [0]
}

add_bits(counts, line)
while((lin = getline()) != null) {
	line = *lin
	add_bits(counts, line)
	num_lines++
}


bits = map(counts, \if(\0 < num_lines / 2) 1 else 0)
nbits = map(bits, \ 1 - \0)

epsilon = bits_to_num(bits)
gamma= bits_to_num(nbits)

print(gamma * epsilon)
