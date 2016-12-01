N, M = map(int, raw_input().split())
S = int(raw_input())
tk = sorted([map(int, raw_input().split()) for _ in xrange(N)])

kigen = 0
on = M == 0
old_t = 0
ans = 0
for t, k in tk:
    if on:
        ans += t - old_t
    kigen += k
    on = kigen >= M
    old_t = t
if on:
    ans += S - old_t

print ans
