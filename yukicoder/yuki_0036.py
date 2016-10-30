import math

N = input()
rootN = int(math.sqrt(N))
i = 2
c = 0
while i <= rootN:
    while N % i == 0:
        N /= i
        c += 1
    if c > 2:
        print 'YES'
        exit()
    i += 1
if c == 2 and N > 1:
    print 'YES'
else:
    print 'NO'

