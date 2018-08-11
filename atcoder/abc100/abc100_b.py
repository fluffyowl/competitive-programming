D, N = map(int, raw_input().split())
A = 100**D
ans = A * N
if N == 100:
    ans += A
print ans
