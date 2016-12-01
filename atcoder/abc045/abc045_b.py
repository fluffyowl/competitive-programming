d = {}
a, b, c = raw_input(), raw_input(), raw_input()
d['a'] = (a, len(a))
d['b'] = (b, len(b))
d['c'] = (c, len(c))
p = {}
p['a'] = 0
p['b'] = 0
p['c'] = 0
t = 'a'

while True:
    p[t] += 1
    if p[t] > d[t][1]:
        print t.upper()
        break
    t = d[t][0][p[t]-1]
