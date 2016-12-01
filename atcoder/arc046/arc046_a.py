n = input()
c = 0
for i in xrange(1, 555556):
    if len(set(list(str(i)))) == 1:
        c += 1
        if c == n:
            print i
            break
