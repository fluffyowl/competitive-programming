from itertools import product
a = zip([25,39,51,76,163,111,128,133,138], [0,0,0,0,0,0,0,0,0]) + [(0,58,136)]
s = set()
for b in product(*a):
    s.add(sum(b))
for b in sorted(list(s)):
    print b
