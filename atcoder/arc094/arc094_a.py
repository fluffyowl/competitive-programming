A, B, C = sorted(map(int, raw_input().split()))
ans = C - B
A += C - B
if (C - A) % 2 == 1:
    C += 1
    ans += 1
ans += (C - A) / 2
print ans
