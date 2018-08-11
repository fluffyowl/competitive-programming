N = input()
ans = float('inf')
for i in xrange(N):
    tmp = 0
    S = raw_input()
    for j in xrange(len(S)-1, -1, -1):
        if S[j] != '0':
            break
        tmp += 1
    ans = min(ans, tmp)
print ans
