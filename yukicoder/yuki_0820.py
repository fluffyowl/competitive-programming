N, K = map(int, raw_input().split())
if N - K >= 0:
    print 2 ** (N - K)
else:
    print 0
