from itertools import permutations, combinations
import random

a = [random.randint(0, 50) for i in xrange(5)]
#a = [2, 3, 4, 5, 0, 0]
r = []
h = set()
for i in permutations(a):
    x = 0
    for j in i:
        x = x + (x ^ j)
    r.append((x, i))
    h.add(x)
for b in sorted(r)[::-1][:10]:
    print b
