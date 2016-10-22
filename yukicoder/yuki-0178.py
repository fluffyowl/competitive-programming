N = input()
a = [(lambda x:x[0]+x[1]*4)(map(int, raw_input().split())) for i in xrange(N)]
print -1 if any(a[i]%2!=a[0]%2 for i in xrange(N)) else sum((max(a)-a[i])/2 for i in xrange(N))

