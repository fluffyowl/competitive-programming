n = int(raw_input())
print sum([i for i in range(10000, n*10000+1, 10000)]) / float(n)
