fn die() {
	i = 0
	\i++ % 100 + 1
}

d = die()

scores = [0, 0]
positions = [1, 2]
player = 0

while (scores[0] < 1000 && scores[1] < 1000) {
	play = player % 2
	positions[play] += d() + d() + d()
	while (positions[play] > 10) positions[play] -= 10
	scores[play] += positions[play]
	player++
}

play = player%2
print(scores[play] * player * 3)
