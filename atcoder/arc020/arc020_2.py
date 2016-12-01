from collections import Counter
n, c = map(int, raw_input().split())
a = [int(raw_input()) for b in xrange(n)]
c1 = Counter(a[::2]).most_common(2)
c2 = Counter(a[1::2]).most_common(2)

if len(c1) == 1:
    c1.append((-1, 0))
if len(c2) == 1:
    c2.append((-1, 0))
a = len(a)
if c1[0][0] != c2[0][0]:
    print (a/2 + a%2 - c1[0][1] + a/2 - c2[0][1]) * c
elif c2[0][1] >= c1[0][1]:
    print (a/2 + a%2 - c1[1][1] + a/2 - c2[0][1]) * c
else:
    print (a/2 + a%2 - c1[0][1] + a/2 - c2[1][1]) * c
