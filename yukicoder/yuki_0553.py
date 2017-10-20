from math import sqrt, log

EPS = 0.5

F1 = 0
F2 = 0
F_inf = 1 / sqrt(19)


def f(n):
    return (sqrt(F1) / F2 - F_inf) / (1 - F_inf) * 1200


def g(x):
    return pow(2, x / 800.0)


def g_inv(x):
    return 800.0 * log(x) / log(2)

gsum = 0

N = input()
for i in xrange(1, N+1):
    RPerf = int(raw_input())
    F1 += pow(0.81, i)
    F2 += pow(0.9, i)
    gsum += g(RPerf) * pow(0.9, i)
    rating = g_inv(gsum / F2) - f(i)

if int(rating + EPS) > int(rating):
    print int(rating) + 1
else:
    print int(rating)

