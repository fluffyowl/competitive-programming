L, N = input(), input()
w = sorted(map(int, raw_input().split()))
ans = 0
for x in w:
    L -= x
    if L < 0:
        break
    ans += 1
print ans

