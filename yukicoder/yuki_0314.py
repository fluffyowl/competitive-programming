N = input()
dp = [[0 for j in xrange(3)] for i in xrange(N+1)]
MOD = 10**9+7

dp[1][1] = 1
for i in xrange(2, N+1):
    dp[i][0] = (dp[i-1][1] + dp[i-1][2]) % MOD
    dp[i][1] = dp[i-1][0]
    dp[i][2] = dp[i-1][1]

print sum(dp[i])%MOD

