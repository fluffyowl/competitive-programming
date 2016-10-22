N = input()
A = map(int, raw_input().split())
ans = 0
for i in xrange(N-2):
    if A[i] < A[i+1] and A[i+1] > A[i+2] and A[i] != A[i+2]:
        ans += 1
    elif A[i] > A[i+1] and A[i+1] < A[i+2] and A[i] != A[i+2]:
        ans += 1
print ans

