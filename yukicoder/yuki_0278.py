import math
N = input()
K = N/(2-(N%2))
ans = []
for n in xrange(1, int(math.sqrt(K))+1):
    if K%n == 0:
        ans.append(n)
        if n*n < K:
            ans.append(K/n)
print sum(ans)

