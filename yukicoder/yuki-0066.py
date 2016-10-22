M = input()
S = [float(raw_input()) for _ in xrange(2**M)]
shouhai = [[S[i]**2/(S[i]**2+S[k]**2) for k in xrange(2**M)] for i in xrange(2**M)]
dp = [[0 for i in xrange(2**M)] for j in xrange(M+1)]
for i in xrange(2**M):
    dp[0][i] = 1 

for i in xrange(1, M+1):
    for j in xrange(2**M):
        for k in xrange(2**M):
            if (j^k) >> (i-1) != 1:
                continue
            dp[i][j] += dp[i-1][j]*dp[i-1][k]*shouhai[j][k]
print dp[M][0]

