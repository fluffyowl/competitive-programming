import math

N = input()
for i in xrange(3, int(math.sqrt(N)+10)):
    if N%i == 0:
        print i
        exit()
print N if N%2 else N/2

