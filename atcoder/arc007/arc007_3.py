from itertools import combinations

s = raw_input()
n = len(s)
p = []
for i, c in enumerate(s):
    if c == 'o':
        p.append(i)
for i in xrange(1, n+1):
    for c in combinations(range(1, n), i-1):
        s = set()
        for j in (0,) + c:
            for k in p:
                s.add((j+k)%n)
        if len(s) == n:
            print i
            exit()
