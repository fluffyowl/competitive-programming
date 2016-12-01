N, M = map(int, raw_input().split())
T = []
for i in range(M):
    T.append(int(raw_input()))
s = set(range(1, N+1))
for i in xrange(len(T)-1, -1, -1):
    t = T[i]
    if t in s:
        print t
        s.remove(t)
for t in sorted(list(s)):
    print t
