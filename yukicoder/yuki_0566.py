from collections import deque

K = input()
N = 2**K - 1
A = [i for i in xrange(1, N+1)]

ans = [0 for _ in xrange(N)]
p = 0
q = deque()
q.append((0, N))

while len(q) > 0:
    l, r = q.popleft()
    m = (l + r) / 2
    ans[p] = A[m]
    p += 1
    if (r - l > 1):
        q.append((l, m))
        q.append((m+1, r))


ans[N-1], ans[N/2-1] = ans[N/2-1], ans[N-1]
print ' '.join(map(str, ans))

