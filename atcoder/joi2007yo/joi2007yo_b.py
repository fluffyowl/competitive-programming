A = [0 for _ in xrange(31)]
for i in xrange(28):
    A[int(raw_input())] += 1
for i in xrange(1, 31):
    if A[i] == 0:
        print i
