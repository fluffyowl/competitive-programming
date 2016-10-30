d = {0: 20104, 1: 20063, 2: 19892, 3: 20011, 4: 19874, 5: 20199, 6: 19898, 7: 20163, 8: 19956, 9: 19841}
a = raw_input()
d2 = {i:a.count(str(i)) for i in xrange(10)}
for i in xrange(10):
    if d[i] < d2[i]:
        x = i
    if d[i] > d2[i]:
        y = i
print x, y

