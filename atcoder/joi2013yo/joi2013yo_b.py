N = input()
A = [map(int, raw_input().split()) for _ in xrange(N)]
for i in xrange(N):
    ans = 0
    for j in xrange(3):
        ok = True
        for k in xrange(N):
            if i != k and A[i][j] == A[k][j]:
                ok = False
        if ok:
            ans += A[i][j]
    print ans
