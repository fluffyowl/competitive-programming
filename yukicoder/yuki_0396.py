N, M = map(int, raw_input().split())
X, Y = map(int, raw_input().split())
if (X-1)/M%2 == 0:
    X = M - (X-1)%M
else:
    X = (X-1)%M+1
    
if (Y-1)/M%2 == 0:
    Y = M - (Y-1)%M
else:
    Y = (Y-1)%M+1

print 'YES' if X == Y else 'NO'

