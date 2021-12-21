scores = map(range(11), fn(a) map(range(11), fn(b) map(range(21), fn(c) map(range(21), fn(d) 0))))

scores[4][8][0][0] = 1
wins = [0, 0]

running = true
while(running) {
	print(wins)
	running = false
	newscores = map(range(11), fn(a) map(range(11), fn(b) map(range(21), fn(c) map(range(21), fn(d) 0))))
	for (p1p in range(10)) {
		for (p2p in range(10)) {
			for (p1s in range(21)) {
				for (p2s in range(21)) {
					num = scores[p1p][p2p][p1s][p2s];
					for (i in range(1, 4)) {
						for (j  in range(1, 4)) {
							p1np = p1p + i
							p2np = p2p + j 
							while (p1np > 10) p1np -= 10
							while (p2np > 10) p2np -= 10
							p1ns = p1s + p1np
							p2ns = p2s + p2np
							if (p1ns >= 21) {
								wins[0] += num
							} else if (p2ns >= 21) {
								wins[1] += num
							} else {
								running = true
								newscores[p1np][p1np][p1ns][p2ns] += num
							}
						}
					}
					
				}
			}
		}
	}
	scores = newscores
}

print(wins)
