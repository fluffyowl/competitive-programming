from fractions import gcd

N = input()
T = [int(raw_input()) for _ in xrange(N)]

def lcm(a, b):
    return a * b / gcd(a, b)

ans = 1
for i in xrange(N):
    ans = lcm(ans, T[i])

print ans
