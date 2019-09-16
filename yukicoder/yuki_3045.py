N, M = map(int, raw_input().split())
if N >= M:
    print 0
    exit()
    
ans = 1
for i in xrange(1, N+1):
    ans = ans * i % M
    
print ans
