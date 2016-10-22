from itertools import permutations
a = map(int, raw_input().split())
b = [a[i-1]*2+a[i]*2 for i in xrange(3)]
c = map(int, raw_input().split())
m = float('inf')
for i,j,k in permutations([0,1,2]):
    m = min(m, b[0]*c[i]+b[1]*c[j]+b[2]*c[k])
print m

