N = int(raw_input())
A = [int(raw_input()) for _ in xrange(N)]
A = [0] + A

for i in xrange(N):
    if abs(A[i]-A[i+1]) != 1:
        print "F"
        exit()
print 'T'

