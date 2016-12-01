N = input()
a = map(int, raw_input().split())
print ' '.join(map(str, [a[0]]+[min(a[i],a[i+1]) for i in xrange(N-2)]+[a[-1]]))
