N = input()
A = [raw_input().split() for i in xrange(N)]
S = set(['-', 'nyanpass'])
m = -1
for i in xrange(N):
    if set([A[j][i] for j in xrange(N)]) == S:
        if m == -1:
            m = i+1
        else:
            m = -1
            break
print m

