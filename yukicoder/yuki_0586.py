p1 = input()
p2 = input()
N = input()
d = {}
for i in xrange(N):
    x = raw_input()
    if x in d:
        d[x] += 1
    else:
        d[x] = 0
ans = 0
for v in d.values():
    ans += v * (p1 + p2)
print ans

