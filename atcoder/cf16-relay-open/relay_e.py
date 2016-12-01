from fractions import gcd
a, b, c, d = map(int, raw_input().split())
x, y = abs(c-a), abs(d-b)
if (x == 0 or y == 0):
    print 0
else:
    print x+y-gcd(x,y)
