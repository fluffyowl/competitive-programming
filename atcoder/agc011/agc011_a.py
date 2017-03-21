N, C, K = map(int, raw_input().split())
T = sorted([int(raw_input()) for i in xrange(N)])

ans = 0
c = C
bus_kita = 0
for i in xrange(N):
    if c == C:
        ans += 1
        c -= 1
        bus_kita = T[i]
    elif c == 0:
        ans += 1
        c = C-1
        bus_kita = T[i]
    elif T[i] - bus_kita > K:
        ans += 1
        c = C-1
        bus_kita = T[i]
    else:
        c -= 1
print ans
