from collections import Counter
N = int(raw_input())
A = sorted(map(int, raw_input().split()))
mod = 10**9+7

if N%2 == 1:
    if A[0] != 0:
        print 0
        exit()
    x = 2
    for i in xrange(1, N, 2):
        if A[i] != x or A[i+1] != x:
            print 0
            exit()
        x += 2
    print pow(2, N/2, mod)
else:
    x = 1
    for i in xrange(0, 2, N):
        if A[i] != x or A[i+1] != x:
            print 0
            exit()
        x += 2
    print pow(2, N/2, mod)
