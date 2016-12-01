def kyori(z):
    return abs(z[0]) + abs(z[1])

s = raw_input()
t = raw_input()
zahyo = [0, 0]
q = 0

for i in s:
    if i == 'L':
        zahyo[0] -= 1
    elif i == 'R':
        zahyo[0] += 1
    elif i == 'U':
        zahyo[1] += 1
    elif i == 'D':
        zahyo[1] -= 1
    else:
        q += 1

k = kyori(zahyo)
if t == '1':
    print k + q
else:
    if k >= q:
        print k - q
    else:
        if (q-k) % 2 == 0:
            print 0
        else:
            print 1
