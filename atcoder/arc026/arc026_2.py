import math
N = int(raw_input())
if N == 1:
    print 'Deficient'
    exit()
if N == 2:
    print 'Deficient'
    exit()
s = 1
for i in xrange(2, int(math.sqrt(N))+1):
    if N%i == 0:
        s += i+N/i
if (int(math.sqrt(N)))**2 == N:
    s -=i

if s == N:
    print 'Perfect'
elif s > N:
    print 'Abundant'
else:
    print 'Deficient'
