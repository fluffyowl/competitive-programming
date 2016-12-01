N = int(raw_input())
a = []
for i in range(N):
    a.append(int(raw_input()))
s = sorted(list(set(a)))
d = {}
for i in range(len(s)):
    d[s[i]] = i
for i in range(N):
    print d[a[i]]
