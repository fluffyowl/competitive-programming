C, D = map(int, raw_input().split())
A = [(140, 170)]

while A[-1][0] * 2 < D:
    A.append((A[-1][0] * 2, A[-1][1] * 2))

ans = 0
for a in A:
    x, y = a
    s = max(x, C)
    t = min(y, D)
    ans += max(0, t - s)
print ans
