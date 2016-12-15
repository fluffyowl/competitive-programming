N, Q = map(int, raw_input().split())
x = 'kogakubu10gokan'
for i in xrange(N):
    y, s = raw_input().split()
    if int(y) > Q:
        print x
        exit()
    x = s
print x
