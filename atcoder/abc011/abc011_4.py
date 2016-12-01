import math
import decimal

def factorial(A):
    s = 1
    for i in range(1, A+1):
        s *= i
    return s

def comb(A, B, C, D):
    return factorial(A+B+C+D)/(factorial(A)*factorial(B)*factorial(C)*factorial(D))

N, D = map(int, raw_input().split())
X, Y = map(int, raw_input().split())

if X % D != 0 or Y % D != 0:
    print 0
    exit()

X, Y = abs(X/D), abs(Y/D)
D = 1

if X+Y > N:
    print 0
    exit()

if (X+Y)%2 != N%2:
    print 0
    exit()

ab = N - (X+Y)

s = 0
for i in range(ab/2+1):
    a = i
    b = ab/2 - i
    s += comb(X+a, a, Y+b, b)

print '%.10f' % (decimal.Decimal(s)/decimal.Decimal(4**N))
