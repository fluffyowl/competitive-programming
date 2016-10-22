import sys

N = input()
A = map(int,raw_input().split())
ans = []
for i in xrange(N):
    for j in xrange(i+1, N):
        if A[i] > A[j]:
            A[i], A[j] = A[j], A[i]
            ans.append((i, j))
print len(ans)
for i, j in ans:
    print i, j
sys.stdout.flush()
raw_input()

