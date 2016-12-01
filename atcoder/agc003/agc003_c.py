N = input()
a = sorted([(int(raw_input()), i) for i in xrange(N)])
print sum([i%2 != j[1]%2 for i, j in enumerate(a)]) / 2
