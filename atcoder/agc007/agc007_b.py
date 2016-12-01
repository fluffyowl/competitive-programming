N = input()
P = map(lambda x:int(x)-1, raw_input().split())

MAX = 10**9
A = [MAX/(N-1)*i for i in xrange(N)]
A[0] += 1
B = A[::-1]

t = 0
for p in P:
    if A[p] + B[p] > t:
        t = A[p] + B[p]
    elif p == N-1:
        B[p] += t+1-A[p]-B[p]
        t += 1
    else:
        A[p] += t+1-A[p]-B[p]
        t += 1
print ' '.join(map(str, A))
print ' '.join(map(str, B))
