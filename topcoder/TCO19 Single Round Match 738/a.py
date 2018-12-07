from itertools import permutations

for k in xrange(1, 6):
    cnt = 0
    for p in permutations(range(k)):
        for i in xrange(k):
            for j in xrange(i+1, k):
                cnt += A[i] > A[j]
    print k, cnt
