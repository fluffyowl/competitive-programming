N = input()
A = map(int, raw_input().split())
A.sort()
cnt = [0 for _ in xrange(9)]
for a in A:
    cnt[min(a/400, 8)] += 1

m = 0
for c in cnt[:-1]:
    if c > 0:
        m += 1
if m == 0 and cnt[:-1] > 0:
    print 1, cnt[-1]
else:
    print m, m + cnt[-1]
