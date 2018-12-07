A = input()
B = input()
C = input()
S = input()
for i in xrange(2):
    for j in xrange(2):
        for k in xrange(2):
            if A + B + C + i + j + k == S:
                print "Yes"
                exit()
print "No"
