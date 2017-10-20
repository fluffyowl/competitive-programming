a, b, c, d = map(int, raw_input().split())
A = [0 for i in xrange(150)]

for i in xrange(150):
    if a <= i < b:
        A[i] += 1
    if c <= i < d:
        A[i] += 1

print A.count(2)
