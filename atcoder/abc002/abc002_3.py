xa, ya, xb, yb, xc, yc = map(int, raw_input().split())

xa -= xc
xb -= xc
ya -= yc
yb -= yc

print abs(xa * yb - xb * ya) / float(2)
