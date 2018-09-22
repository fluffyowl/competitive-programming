A, B = map(int, raw_input().split())
for i in xrange(1, 4):
    if (A * B * i) % 2 == 1:
        print "Yes"
        exit()
print "No"
