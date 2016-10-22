N = input()
for i in xrange(N):
    g, d = map(int, raw_input().split())
    if g-30000*d >= 500000:
        print 'YES'
        for _ in xrange(6):
            print i+1
        exit()
print 'NO'

