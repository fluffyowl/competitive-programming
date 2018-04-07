from math import sqrt

N = input()
D = 8 * N + 1
Q = int(sqrt(D))
if Q * Q != D:
    print 'NO'
elif (-1 + Q) % 2 != 0:
    print 'NO'
else:
    print 'YES'
    print (Q - 1) / 2

