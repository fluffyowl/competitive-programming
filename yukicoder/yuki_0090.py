from itertools import permutations

N, M = map(int, raw_input().split())
iis = [map(int, raw_input().split()) for _ in xrange(M)]

m1 = 0
for p in permutations(range(N)):
    m2 = 0
    for item1, item2, score in iis:
        if p[item1] < p[item2]:
            m2 += score
    m1 = max(m1, m2)
print m1        

