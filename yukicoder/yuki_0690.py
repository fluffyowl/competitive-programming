K = input()

if K == 0:
    print 2, 0
    exit()

ans = []
for i in xrange(31):
    ans.append((i, i+1))

A = [1 for i in xrange(32)]
x = 1

for i in xrange(29, 0, -1):
    if x * 2 > K:
        K -= x
        break
    for j in xrange(i+2, 32):
        ans.append((i, j))
    x *= 2
    A[i] = x

for i in xrange(30, 1, -1):
    if K == 0:
        break
    if K & A[i]:
        ans.append((0, i))
        K -= A[i]

print 32, len(ans)
for a in ans:
    print a[0]+1, a[1]+1

