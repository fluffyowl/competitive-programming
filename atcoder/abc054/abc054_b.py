n, m = map(int, raw_input().split())

A = [raw_input() for _ in xrange(n)]
B = [raw_input() for _ in xrange(m)]

for r in xrange(n-m+1):
    for c in xrange(n-m+1):
        f = True
        for x in xrange(m):
            for y in xrange(m):
                if A[r+x][c+y] != B[x][y]:
                    f = False
                    break
            if not f:
                break
        if f:
            print "Yes"
            exit()
print "No"
