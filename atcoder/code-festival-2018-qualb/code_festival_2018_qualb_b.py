N, X = map(int, raw_input().split())
AB = [map(int, raw_input().split()) for _ in xrange(N)]

AB.sort(key=lambda x: -x[1])
ans = 0
for a, b in AB:
    ans += a * b

ans += X * AB[0][1]

print ans
