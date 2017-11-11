input()
A = sorted(filter(lambda x: x, map(int, raw_input().split())))
N = len(A)

if N == 0:
    print "B"
elif all(a == 1 for a in A) and N % 2 == 1:
    print "A"
elif A[-1] == 2 and all(a == 1 for a in A[:-1]) and N % 2 == 0:
    print "A"
else:
    print "B"
