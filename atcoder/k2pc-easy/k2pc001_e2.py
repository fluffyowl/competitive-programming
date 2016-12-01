N = input()
a = sorted(map(int, raw_input().split()), reverse=True)
b = [raw_input() for i in xrange(N)]
c = [''.join([b[i][j] for i in xrange(N)]) for j in xrange(7)]
d = sorted(map(lambda x:max(map(len, x.split('-'))), c), reverse=True)
print 'YES' if all(x[0] >= x[1] for x in zip(a, d)) else 'NO'
