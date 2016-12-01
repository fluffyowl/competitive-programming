N, M = map(int, raw_input().split())
red = set([1])
num = [1 for i in xrange(N+1)]
for i in xrange(M):
    x, y = map(int, raw_input().split())
    num[x] -= 1
    num[y] += 1
    if x in red:
        red.add(y)
        if num[x] == 0:
            red.remove(x)
print len(red)
