V = map(int, raw_input().split())

def solve(a, b, c):
    dp = [float('inf') for i in xrange(31)]
    dp[0] = 0
    for i in xrange(a, 31):
        if i - a >= 0:
            dp[i] = min(dp[i], dp[i-a]+1)
        if i - b >= 0:
            dp[i] = min(dp[i], dp[i-b]+1)
        if i - c >= 0:
            dp[i] = min(dp[i], dp[i-c]+1)
    return dp[V[0]]+dp[V[1]]+dp[V[2]]+dp[V[3]]

ans = float('inf')
for a in xrange(1, 31):
    for b in xrange(a+1, 31):
        for c in xrange(b+1, 31):
            ans = min(ans, solve(a, b, c))
print ans

