n = input()
a = input()
ans = 1
print 1
for i in xrange(n-1):
    b = int(raw_input())
    if (b > a):
        ans += 1
    print ans

