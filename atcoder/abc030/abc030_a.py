A, B, C, D = map(int, raw_input().split())
 
t = float(B)/A
a = float(D)/C
 
if t>a:
    print 'TAKAHASHI'
elif t<a:
    print 'AOKI'
else:
    print 'DRAW'
