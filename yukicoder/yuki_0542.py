a, b = map(int, raw_input().split())
s = set()

for i in xrange(a+1):
    for j in xrange(b+1):
        s.add(i + j * 5)

s.discard(0)
s = sorted(list(s))

for i in s:
    print i

