n, m = input(), input()
if m == 0:
    print 1
else:
    m = m%4
    if m == 0:
        m = 4
    print (n%10)**m%10 

