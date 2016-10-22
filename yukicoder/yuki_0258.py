N = input()
V = map(int,raw_input().split())
dp = [(V[i], [i]) for i in xrange(N)]

for i in xrange(N):
    for j in xrange(i-1):
        if dp[i][0] < dp[j][0]+V[i]:
            dp[i] = (dp[j][0]+V[i], dp[j][1]+[i])

m = max(dp, key=lambda x:x[0])
print m[0]
print ' '.join(map(lambda y:str(y+1), m[1]))

