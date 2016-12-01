a, b= input(), input()
s = 0
MOD = 10**9+7
for i in xrange(a, b+1):
    s = (s+i*i*(i+1)/2)%MOD
print s
