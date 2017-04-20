a = raw_input()
b = raw_input()
ans = ""
for i in xrange(len(a)):
    ans += a[i]
    if i < len(b):
       ans += b[i]
print ans
