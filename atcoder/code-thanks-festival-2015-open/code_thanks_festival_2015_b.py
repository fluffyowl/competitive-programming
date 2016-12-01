a = set(map(int, raw_input().split()))
b = set(map(int, raw_input().split()))
c = int(raw_input())

s = []
if c in a:
    s += [i for i in b]
if c in b:
    s += [i for i in a]

s = sorted(list(set(s)))
print len(s)
for i in s:
    print i
