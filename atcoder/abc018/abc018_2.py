S = list(raw_input())
N = int(raw_input())

for i in range(N):
    L, R = map(int, raw_input().split())
    S[L-1:R] = S[R-1:L-2:-1] if L-2 >= 0 else S[R-1::-1]
print ''.join(S)
