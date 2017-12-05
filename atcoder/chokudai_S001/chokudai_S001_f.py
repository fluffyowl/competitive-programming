N = input()
A = map(int, raw_input().split())
m = 0
ans = 0
for i in xrange(N):
    if A[i] > m:
        ans += 1
        m = A[i]
print ans N = input()
A = map(int, raw_input().split())
m = 0
ans = 0
for i in xrange(N):
    if A[i] > m:
        ans += 1
        m = A[i]
print ans
