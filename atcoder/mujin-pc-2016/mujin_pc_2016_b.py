import math

L = map(int, raw_input().split())
m = max(L)
s = sum(L)
ans = s*s*math.pi
ans -= (2*m-s)**2*math.pi if m>s-m else 0
print '%.10f'%ans
