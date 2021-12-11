nums = map(str_split(*getline(), ","), int)
sort(nums)
pos = nums[len(nums) / 2]

print(sum(map(map(nums, \0 - pos), abs)))

