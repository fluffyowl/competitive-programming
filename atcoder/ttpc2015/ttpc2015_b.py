N, B, C = map(int, raw_input().split())
A = map(int, raw_input().split())[::-1]
ans = 0
for a in A:
    if C <= 0:
        break
    ans += a * min(B, C)
    C -= B
print ans
