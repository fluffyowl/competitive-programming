N = input()
A = map(int, raw_input().split())

NA = sum(A)
mv = float('inf')
mi = -1

for i in xrange(N):
    v = abs(NA - A[i] * N)
    if v < mv:
        mv = v
        mi = i

print mi
