N = input()
x = sorted(map(int, raw_input().split()))

m = max(x)
dp = [float('-inf') for _ in xrange(m+1)]
for a in x:
    dp[a] = 1

for a in x:
    b = a*2
    c = dp[a]
    while b <= m:
        if dp[b] != float('-inf'):
            dp[b] = max(c+1, dp[b])
        b += a

print max(dp)
