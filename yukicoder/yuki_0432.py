import sys
sys.setrecursionlimit(10**3+10)

def f(a, b):
    return a+b if a+b < 10 else f(int(str(a+b)[0]), int(str(a+b)[1]))

mem = [[f(i, j) for j in xrange(10)] for i in xrange(10)]

def g(L, n):
    if n == 1:
        return L[0]
    for i in xrange(n-1):
        L[i] = mem[L[i]][L[i+1]]
    return g(L, n-1)

for i in xrange(input()):
    s = map(int, list(raw_input()))
    print g(s, len(s))

