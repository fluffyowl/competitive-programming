P, Q, R = map(int, input().split())
A, B, C = map(int, input().split())

lo = max(P * (A - 1) + 1, Q * (A + B - 1) + 1, R * (A + B + C - 1) + 1)
hi = min(P * A, Q * (A + B), R * (A + B + C))

if lo > hi:
    print(-1)
else:
    print(lo, hi)
