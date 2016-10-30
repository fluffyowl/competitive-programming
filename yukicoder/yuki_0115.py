N, D, K = map(int, raw_input().split())
if D < K:
    print -1
    exit()
if D < K*(K+1)/2 or D > K*(2*N-K+1)/2:
    print -1
    exit()

ans = range(1, K+1)
i = 1
while sum(ans) < D:
    diff = D - sum(ans) + ans[-i]
    ans[-i] = min(N-i+1, diff)
    i += 1
print ' '.join(map(str, ans))

