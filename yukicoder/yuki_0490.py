n = input()
A = map(int, raw_input().split())

for i in xrange(1, 2*n-3):
    for p in xrange(i+1):
        if p > n-1:
            break
        q = i - p
        if (q <= p or q > n-1):
            continue
        if A[p] > A[q]:
            A[p], A[q] = A[q], A[p]
print " ".join(map(str, A))

