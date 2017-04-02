a = 'yukicoder'
b = raw_input()
for i in xrange(len(a)):
    if a[i] != b[i]:
        print a[i]
        exit()

