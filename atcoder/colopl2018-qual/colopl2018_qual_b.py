N, T = map(int, raw_input().split())
S = raw_input()
X = [int(raw_input()) for i in xrange(N)]

ans = 0
for i in xrange(N):
    if S[i] == '0':
        ans += X[i]
    else:
        ans += min(X[i], T)

print ans N, T = map(int, raw_input().split())
S = raw_input()
X = [int(raw_input()) for i in xrange(N)]

ans = 0
for i in xrange(N):
    if S[i] == '0':
        ans += X[i]
    else:
        ans += min(X[i], T)

print ans
