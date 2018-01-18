N = input()
A = map(int, raw_input().split())

mi = -1
mv = -1

for i in xrange(N):
    if abs(A[i]) > mv:
        mv = abs(A[i])
        mi = i

if mv == 0:
    print 0
    exit()

ans = []

for i in xrange(N):
    if i != mi:
        ans.append((mi+1, i+1))

if A[mi] > 0:
    for i in xrange(N-1):
        ans.append((i+1, i+2))
else:
    for i in xrange(N-1, 0, -1):
        ans.append((i+1, i))

print len(ans)
for a, b in ans:
    print a, b N = input()
A = map(int, raw_input().split())

mi = -1
mv = -1

for i in xrange(N):
    if abs(A[i]) > mv:
        mv = abs(A[i])
        mi = i

if mv == 0:
    print 0
    exit()

ans = []

for i in xrange(N):
    if i != mi:
        ans.append((mi+1, i+1))

if A[mi] > 0:
    for i in xrange(N-1):
        ans.append((i+1, i+2))
else:
    for i in xrange(N-1, 0, -1):
        ans.append((i+1, i))

print len(ans)
for a, b in ans:
    print a, b
