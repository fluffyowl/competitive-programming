N = input()
for i in xrange(1, 11):
    for j in xrange(1, 11):
        if i + j == N:
            print i, j
            exit()

