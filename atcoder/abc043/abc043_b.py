s = []
for a in raw_input():
    if a == 'B':
        if len(s) > 0:
            s.pop()
    else:
        s.append(a)
print ''.join(s)
