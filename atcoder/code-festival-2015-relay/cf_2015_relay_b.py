a = []
for i in range(10):
    s = raw_input()
    a += filter(lambda i:s[i]=='o', range(10))
print 'Yes' if len(set(a)) == 10 else 'No'
