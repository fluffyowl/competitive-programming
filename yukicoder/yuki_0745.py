A, B, C, D = map(int, raw_input().split())
if D >= 10:
    print "Impossible"
    exit()
cnt = 0
ans = 0
for i in xrange(B):
    cnt += 1
    x = (cnt - 1) / 100
    ans += 50 * 2 ** x
for i in xrange(A):
    cnt += 1
    x = (cnt - 1) / 100
    ans += 100 * 2 ** x
print "Possible"
print ans

