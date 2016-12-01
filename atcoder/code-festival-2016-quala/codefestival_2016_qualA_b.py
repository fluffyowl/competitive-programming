N = input()
a = map(lambda x:int(x)-1, raw_input().split())
ans = 0
for i in xrange(len(a)):
    if i == a[a[i]]:
       ans += 1
print ans/2
