n, k = map(int,raw_input().split())
s = 0
for i in xrange(k):
    s += int(raw_input())
    if s >= k:
        break
print i+1
