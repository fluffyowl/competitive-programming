N = input()
D = [0 for _ in xrange(10000)]
for i in xrange(N):
    D[raw_input().count('^')] += 1
m = -1
v = -1
for i in xrange(9999, -1, -1):
    if D[i] > v:
        m = i
        v = D[i]
print m

