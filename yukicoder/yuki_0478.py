n, k = map(int, raw_input().split())
a = [0 for _ in xrange(n)]
for i in xrange(k+2):
    a[i] = i
for i in xrange(k+2, n):
    if i < 2:
        a[i] = i
    elif a[i-1] - a[i-2] > 0:
        a[i] = a[i-2]-1
    else:
        a[i] = a[i-2]+1
print ' '.join(map(str, map(lambda x:x+100000, a)))

