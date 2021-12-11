fn tri(n) {
	n * (n + 1) / 2
}

nums = map(str_split(*getline(), ","), int)
pos = (sum(nums) + 1) / (len(nums))
pos1 = pos + 1

print(sum(map(map(nums, \abs(\0 - pos)), tri)))
print(sum(map(map(nums, \abs(\0 - pos1)), tri)))

