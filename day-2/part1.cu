fn parse_int(str, start) {
	rv = 0
	while (start < len(str) - 1) {
		rv *= 10
		rv += str[start++] - '0'
	}
	rv
}

fn min(a, b) {
	if (a < b) { a } else { b }
}

fn starts_with(str, prefix) {
	i = 0
	rv = true
	while (i < min(len(str), len(prefix))) {
		if (str[i] != prefix[i]) rv = false
		i++
	}
	rv
}

y = 0
x = 0

while ((a = getline()) != null) {
	line = *a
	if (starts_with(line, "forward ")) {
		x += parse_int(line, 8)
	}
	else if (starts_with(line, "down ")) {
		y -= parse_int(line, 5)
	}
	else if (starts_with(line, "up ")) {
		y += parse_int(line, 3)
	}
}

if (y < 0) {
	y = -y;
}

print(x*y)
