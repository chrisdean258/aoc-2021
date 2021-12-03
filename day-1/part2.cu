fn int(str) {
	i = -1
	rv = 0
	while(++i < len(str) - 1) {
		rv = 10 * rv + str[i] - '0'
	}
	rv
}

fn sum(a) {
	i = 0
	rv = 0
	while(i < len(a)) rv += a[i++]
	rv
}

rv = 0
vals = [ int(*getline()), int(*getline()), int(*getline()) ]
prev_sum = sum(vals)

while ((a = getline()) != null) {
	vals = [vals[1], vals[2], int(*a)]
	new_sum = sum(vals)
	if (new_sum > prev_sum) rv++
	prev_sum = new_sum
}
print(rv)
