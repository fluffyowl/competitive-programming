N = input()
s = set()

for i in xrange(1, 10**6+5):
    if N % i == 0 and i <= N / i:
        s.add(str(i) + str(N/i))
        if i != N / i:
            s.add(str(N/i) + str(i))

print len(s)

