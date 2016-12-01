n = int(raw_input())
m = map(int, raw_input().split())
print '%.10f' % (float(m[-1]-m[0]) / (n-1))
