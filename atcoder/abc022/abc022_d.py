import math

N = input()
A = []
B = []
Aa = A.append
Ba = B.append
Amin = [0, 0]
Bmin = [0, 0]
for i in xrange(N):
    x, y = map(int, raw_input().split())
    Amin[0] += x
    Amin[1] += y
    Aa((x, y))
for i in xrange(N):
    x, y = map(int, raw_input().split())
    Bmin[0] += x
    Bmin[1] += y
    Ba((x, y))

Amin[0] /= float(N)
Amin[1] /= float(N)
Bmin[0] /= float(N)
Bmin[1] /= float(N)

Asum = 0
Bsum = 0

Ax, Ay = Amin
for x, y in A:
    Asum += math.sqrt((x - Ax)**2 + (y - Ay)**2)
Bx, By = Bmin
for x, y in B:
    Bsum += math.sqrt((x - Bx)**2 + (y - By)**2)

print '%.10f' % (Bsum/Asum)
