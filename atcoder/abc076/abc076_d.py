from fractions import Fraction as F

N = input()
T = map(int, raw_input().split())
V = map(int, raw_input().split())

VL = [V[i] for i in xrange(N)]
VL.append(0)
for i in xrange(N-1, -1, -1):
    VL[i] = min(VL[i], VL[i+1] + T[i])

v1 = F(0)
v2 = F(0)
ans = F(0)

for i in xrange(N):
    t1 = F(0)
    v2 = F(v1)

    while t1 < T[i] and v2 < V[i] and v2 - (T[i] - t1) < VL[i+1]:
        t1 += F(1, 2)
        v2 += F(1, 2)
    v2 = v1 + t1
    ans += (v1 + v2) / F(2) * t1

    t2 = F(0)
    while t1 + t2 < T[i] and v2 - (T[i] - t1 - t2) < VL[i+1]:
        t2 += F(1, 2)
    ans += v2 * t2

    v3 = v2 - (T[i] - t1 - t2)
    ans += (v2 + v3) / F(2) * (T[i] - t1 - t2)

    v1 = v3

print "%.09f" % ans
