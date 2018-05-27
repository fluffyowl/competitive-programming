A = sorted(map(int, raw_input().split()))
k = input()
for i in xrange(k):
    A[-1] *= 2
print sum(A)
