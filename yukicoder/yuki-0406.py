N = input()-1
x = sorted(map(int, raw_input().split()))
print 'YES' if all(x[i+1]-x[i]==x[1]-x[0] for i in xrange(N)) and x[1]!=x[0] else 'NO'
