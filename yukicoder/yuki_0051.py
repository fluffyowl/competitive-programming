W, D = input(), input()
for d in xrange(D, 0, -1):
    w = W/(d*d)
    if W <= w:
        print w
        exit()
    W -= w
print w
