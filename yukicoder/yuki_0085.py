N, M, C = map(int, raw_input().split())
N, M = sorted([N, M])
print 'NO' if (N==1 and M>2) or(N%2==1 and M%2==1) else 'YES'

