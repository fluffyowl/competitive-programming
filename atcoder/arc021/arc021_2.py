L = int(raw_input())
B = [int(raw_input()) for i in xrange(L)]
a = [0 for i in xrange(L)]
for i in xrange(L-1):
    a[i+1] = a[i]^B[i]
if a[L-1] != a[0]^B[L-1]:
    print -1
else:
    for i in a:
        print i
