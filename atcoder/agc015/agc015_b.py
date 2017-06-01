S = raw_input()
N = len(S)
ans = 0
for i in xrange(N):
    if S[i] == 'U':
        ans += N - i - 1
        ans += i * 2
    else:
        ans += (N - i - 1) * 2
        ans += i
print ans
