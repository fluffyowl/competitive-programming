import math
n = int(raw_input())
if n == 1:
    print 'NO'
    exit()
if n == 2:
    print 'YES'
    exit()
if n % 2 == 0:
    print 'NO'
    exit()
if n == 3:
    print 'YES'
    exit()

for i in range(3, int(math.sqrt(n))+2, 2):
    if n % i == 0:
        print 'NO'
        exit()
print 'YES'
