from math import sqrt

R, D = map(float, raw_input().split())
print "%.9f" % (sqrt(D*D-R*R))

