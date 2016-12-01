N = 2**input()
A = [int(raw_input()) for _ in xrange(N)]
while N > 1:
    for i in xrange(N/2):
        if A[i*2] > A[i*2+1]:
            A[i] = A[i*2] - A[i*2+1]
        elif A[i*2] == A[i*2+1]:
            A[i] = A[i*2]
        else:
            A[i] = A[i*2+1] - A[i*2]
    N /= 2
print A[0]
