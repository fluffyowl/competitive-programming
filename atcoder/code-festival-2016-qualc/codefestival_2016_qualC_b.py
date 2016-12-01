K, T = map(int, raw_input().split())
A = map(int, raw_input().split())
A = sorted([[i, j] for i, j in enumerate(A)], key=lambda x:x[1])
last = -1
for i in xrange(K):
    A = sorted(A, key=lambda x:x[1])
    if len(A) == 1:
        print A[0][1] - 1 + (last == A[0][0])
        exit()
    if last == A[-1][0]:
        A[-2][1] -= 1
        last = A[-2][0]
        if A[-2][1] == 0:
            A.pop(-2)
    else:
        A[-1][1] -= 1
        last = A[-1][0]
        if A[-1][1] == 0:
            A.pop()
print 0
