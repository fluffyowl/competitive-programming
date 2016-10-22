N = input()
a1 = 0
a2 = 0
for _ in xrange(N):
    t, s = raw_input().split()
    a1 += min(12*int(t)/1000, len(s))
    a2 += len(s)
print a1, a2-a1
