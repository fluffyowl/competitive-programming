N, T = map(int, raw_input().split())
t = map(int, raw_input().split())
ans = 0

for i in xrange(N-1):
    ans += min(t[i+1] - t[i], T)

ans += T

print ans
