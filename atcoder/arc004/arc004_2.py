n = int(raw_input())
d = []
for i in range(n):
    d.append(int(raw_input()))

s = sum(d)
print s
for i in d:
    if i > s-i:
        print 2*i-s
        break
else:
    print 0
