A, B, C, D = map(int, raw_input().split())

ans = 0

for i in xrange(A+1):
    j = i * C
    if j <= B and i + j <= D:
        ans = i

print ans

