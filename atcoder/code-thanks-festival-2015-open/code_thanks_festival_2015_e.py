for i in range(int(raw_input())):
    s, t = raw_input().split()
    diff = set(list(s)) - set(list(t))
    for j in diff:
        s = s.replace(j, '')
    print 'YES' if t in s else 'NO'
