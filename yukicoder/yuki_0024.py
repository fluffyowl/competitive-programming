s = [str(i) for i in range(10)]
for i in range(input()):
    a = raw_input().split()
    b = a[:4]
    c = [str(j) for j in range(10) if not str(j) in b] if a[4]=='NO' else b
    s = filter(lambda x:x in c, s)
print s[0]

