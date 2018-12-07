N, M, P, Q = map(int, raw_input().split())
m = 1
ans = 0
while N > 0:
    if P <= m and m < P + Q:
        N -= 2 * M
    else:
        N -= M
    ans += 1
    m = (m + 1) % 12
    if m == 0:
        m = 12
print ans

