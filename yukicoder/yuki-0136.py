N, K = map(int, raw_input().split())
for i in xrange(2, N+1):
    if N%i == 0:
        print N/i
        exit()
print 1

