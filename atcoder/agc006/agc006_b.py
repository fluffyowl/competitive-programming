N, x = map(int, raw_input().split())
M = 2*N-1
if x == 1 or x == M:
    print 'No'
    exit()

if N == 2:
    if x == 2:
        print 'Yes'
        print 1
        print 2
        print 3
    else: 'No'
    exit()

if x == 2:
    core = [3, 2, 1, 4]
else:
    core = [x-1, x, x+1, x-2]

ans = [i for i in xrange(1, M+1) if i not in core]
ans = ans[:(M-4)/2] + core + ans[(M-4)/2:]
print 'Yes'
for a in ans:
    print a
