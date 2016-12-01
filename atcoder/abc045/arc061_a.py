S = raw_input()
N = len(S)

ans = 0
for i in xrange(N):
    for keta in xrange(1, N-i+1):
        if keta == N:
            ans += int(S)
        elif i == 0 or i+keta==N:
            ans += int(S[i:i+keta]) * 2**(N-keta-1)
        else:
            ans += int(S[i:i+keta]) * 2**(N-keta-2)
print ans
