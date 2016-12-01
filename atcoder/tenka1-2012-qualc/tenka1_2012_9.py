n = input()
if n==1:
    print 0
    exit()
t = [True for i in xrange(n)]
t[0], t[1] = False, False
for i in xrange(2, n):
    if t[i]:
        m = i*2
        while m <= n-1:
            t[m] = False
            m += i
print sum(t)
