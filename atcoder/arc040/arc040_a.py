t = 0
a = 0
for i in range(int(raw_input())):
    f = list(raw_input())
    t += len(filter(lambda x:x=='R', f))
    a += len(filter(lambda x:x=='B', f))

if t > a:
    print 'TAKAHASHI'
elif t < a:
    print 'AOKI'
else:
    print 'DRAW'
