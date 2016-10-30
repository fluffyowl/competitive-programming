N = input()
K = input()
taro = [[0 for j in xrange(6*N+1)] for i in xrange(N+1)]
for i in xrange(1, 7):
    taro[1][i] = 1
for i in xrange(1, N+1):
    for j in xrange(6*N+1):
        for k in xrange(1, 7):
            if j-k >= 1:
                taro[i][j] += taro[i-1][j-k]

jiro = [[0 for j in xrange(6*N+1)] for i in xrange(N+1)]
ikasama = range(1, 7) if N != K else [4,4,5,5,6,6]
for i in ikasama:
    jiro[1][i] += 1
for i in xrange(1, N+1):
    if i > N-K:
        ikasama = [4, 4, 5, 5, 6, 6]
    for j in xrange(6*N+1):
        for k in ikasama:
            if j-k >= 1:
                jiro[i][j] += jiro[i-1][j-k]

ans = 0
t = 0
for i in xrange(6*N):
    t += taro[N][i]
    ans += t*jiro[N][i+1]
print float(ans)/6**(N*2)

