c = None
s = 0
ans = []
for i in raw_input():
    if i == c:
        s += 1
    else:
        if c is not None:
            ans.append(c+str(s))
        c = i
        s = 1
ans.append(c+str(s))
print ''.join(ans)
