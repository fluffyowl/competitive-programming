import math
N = input()
root = int(math.sqrt(1+8*N))
if root**2 == 1+N*8 and (root-1)%2 == 0:
    print (root-1)/2
else:
    print -1
