fn parse_int(stri) {
	i  = 0
	rv = 0
	while(i < len(stri) - 1) {
		rv *= 10
		rv += stri[i++] - '0'
	}
	rv
}

rv = 0
prev = parse_int(*getline())
while((a = getline()) != null){
	num = parse_int(*a)
	if (num > prev) rv++
	prev = num
}
print(rv)
