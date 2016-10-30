N = input()
A = map(int, raw_input().split())
i = 1
while i*(i+1)-i <= sum(A):
    i += 1
i -= 1
B = range(1, i+1) + range(i-1, 0, -1)
while len(B) < len(A):
    B.append(0)
ans = 0
for i in xrange(len(A)):
    ans += max(0, A[i]-B[i])
print ans

