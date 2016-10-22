s, t, u = raw_input().split()
s, t, u = list(s), int(t), int(u)
s[t] = ''
s[u] = ''
print ''.join(s)

