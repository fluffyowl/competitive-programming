a, b = map(int, raw_input().split())
ans = 0
while a != b:
    if b - a >= 8:
        a += 10
    elif b - a >= 3:
        a += 5
    elif b - a >= 1:
        a += 1
    elif b - a >= -2:
        a -= 1
    elif b - a >= -7:
        a -= 5
    else:
        a -= 10
    ans += 1
print ans
