K = input()
table = [0 for _ in xrange(201)]
for i in [2,3,5,7,11,13]:
    for j in [4,6,8,9,10,12]:
        table[i*j] += 1
print table[K]/36.
