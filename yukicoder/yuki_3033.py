N, M, X = map(int, raw_input().split())
A = M
B = N - M
print 'YES' if X - B >= 3 else "NO"

