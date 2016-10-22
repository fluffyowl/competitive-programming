N, S, K = map(int, raw_input().split())
dp = [[0 for j in xrange(S+1)] for i in xrange(N)]
for i in xrange(S):
    dp[0] = range(1, S+2)

for i in xrange(1, N):
    for j in xrange(i*K, S+1):
        dp[i][j] = dp[i-1][j-K]
        if j != 0:
            dp[i][j] += dp[i][j-1]
print dp
