m, n, N = map(int, raw_input().split())
uru = N
amari = 0
ans = 0
while uru > 0:
    amari += uru
    ans += uru
    uru = 0
    while amari >= m:
        uru += n
        amari -= m
print ans
