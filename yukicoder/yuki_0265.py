N = input()
d = input()
S = filter(None, raw_input().replace('+', ' ').replace('d{', ' { ').replace('}', ' } ').split())
coef = [0 for i in xrange(d+1)]
dx = 0

for s in S:
    if s == '{':
        dx += 1
    elif s == '}':
        dx -= 1
    else:
        t = sorted(s.split('*'))
        if t[0].isdigit():
            c = int(t[0])
            t.pop(0)
        else:
            c = 1
        for i in xrange(len(t), len(t)-dx, -1):
            c *= i
        e = len(t) - dx
        if e >= 0:
            coef[e] += c
print ' '.join(map(str, coef))

