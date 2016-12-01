import math
N = int(raw_input())
if N == 1:
    print 'Not Prime'
    exit()
elif N == 2 or N == 3 or N == 5:
    print 'Prime'
    exit()

if N % 2 != 0 and N % 5 != 0 and N % 3 != 0:
    print 'Prime'
    exit()

print 'Not Prime'
