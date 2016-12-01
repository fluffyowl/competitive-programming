import math
n = input()
n2 = sum(range(1, n+1))
if n == 1:
    print 'BOWWOW'
    exit()
for i in range(2, int(math.sqrt(n2))+1):
    if n2%i == 0:
        print 'BOWWOW'
        break
else:
    print 'WANWAN'
