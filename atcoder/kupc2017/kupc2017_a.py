N, K = map(int, raw_input().split())
A = sorted(map(int, raw_input().split()))[::-1]

ans = 0
tmp = 0
for a in A:
    ans += 1
    tmp += a
    if tmp >= K:
        print ans
        exit()
print -1
