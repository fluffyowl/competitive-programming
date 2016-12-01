n, m = map(int, raw_input().split())
a = sorted(map(int, raw_input().split()))[::-1]
b = sorted(map(int, raw_input().split()))[::-1]
print 'YES' if all(x[0]-x[1]>=0 for x in zip(a,b)) and n>=m else 'NO'
