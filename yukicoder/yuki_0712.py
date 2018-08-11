ans = 0
N, M = map(int,raw_input().split())
for i in xrange(N):
    ans += raw_input().count('W')
print ans

