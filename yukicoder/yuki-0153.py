N = input()
if N == 1:
    print 'B'
    exit()
grundy = [0 for _ in xrange(N+1)]
grundy[2] = 1

for i in xrange(3, N+1):
    m1 = grundy[i/3] ^ grundy[i/3+(i%3>0)] ^ grundy[i/3+(i%3>1)]
    m2 = grundy[i/2] ^ grundy[i/2+(i%2==1)]
    while grundy[i] in (m1, m2):
        grundy[i] += 1

print 'A' if grundy[N] else 'B'

