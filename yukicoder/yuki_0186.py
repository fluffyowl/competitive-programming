from fractions import gcd

x1, y1 = map(int, raw_input().split())
x2, y2 = map(int, raw_input().split())
x3, y3 = map(int, raw_input().split())

flag = True
for i in xrange(y2):
    a = x1 + (y1 * i)
    if a % y2 == x2:
        flag = False
        break
    
if flag:
    print -1
    exit()

flag = True
for i in xrange(y3):
    b = a + (y1 * y2 / gcd(y1, y2) * i)
    if b % y3 == x3:
        flag = False
        break
        
if flag:
    print -1
    exit()

print b if b > 0 else min(x1, x2, x3) + y1 * y2 * y3 / (gcd(y1, y2) * gcd(y1*y2, y3))

