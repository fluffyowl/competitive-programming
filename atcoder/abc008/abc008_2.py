N = int(raw_input())
d = {}
for i in range(N):
    s = raw_input()
    if s in d:
        d[s] += 1
    else:
        d[s] = 1
print sorted(d.items(), key=lambda x:x[1], reverse=True)[0][0]
