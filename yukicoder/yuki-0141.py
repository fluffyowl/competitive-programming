def gcd(a, b):
    while b:
        a, b = b, a%b
    return a

N, M = map(int, raw_input().split())
a = gcd(N, M)
N, M = N/a, M/a
ans = 0
while N != M:
    if N < M:
        N, M = M, N
        ans += 1
    elif N/M > 1:
        L = N/M-1
        N -= L*M
        ans += L
    else:
        N -= M
        ans += 1
print ans

