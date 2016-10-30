D = input()
Ad = raw_input()
A = map(int, Ad.split())[::-1]

if D < 3:
    print D
    print Ad
    exit()

for i in xrange(D-2):
    A[i+2] += A[i]
    A[i] = 0


if all(a == 0 for a in A):
    print 0
    print 0
else:
    A = A[::-1]
    while A[-1] == 0:
        A.pop()
    print len(A)-1
    print ' '.join(map(str, A))
    
    

