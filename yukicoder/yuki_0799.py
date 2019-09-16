A, B, C, D = map(int, raw_input().split())
ans = 0

for i in xrange(A, B+1):
    for j in xrange(C, D+1):
        if i != j:
            ans += 1
print ans

