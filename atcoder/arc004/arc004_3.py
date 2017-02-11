from fractions import Fraction

X, Y = map(int, raw_input().split('/'))

flag = True
for N in xrange(2*X/Y-3, 2*X/Y+4):
    M = Fraction(N * N + N - Fraction(2 * X * N, Y), 2)
    if int(M) == M and (N > 0 and M > 0) and M <= N:
        if Fraction(N*(N+1)/2-M, N) == Fraction(X, Y):
            flag = False
            print N, M

if flag:
    print 'Impossible'
