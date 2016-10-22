N = list(raw_input())
ideal = sorted(N)[::-1]
for i, s in enumerate(N):
    if s != ideal[i]:
        for j in xrange(len(N)-1, i, -1):
            if N[j] == ideal[i]:
                N[i], N[j] = N[j], N[i]
                print ''.join(N)
                exit()
print ''.join(N)
