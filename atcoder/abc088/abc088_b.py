N = input()
A = map(int, raw_input().split())
A.sort(key=lambda x:-x)

a = 0
b = 0
for i in xrange(N):
    if i % 2 == 0:
        a += A[i]
    else:
        b += A[i]

print a - b
