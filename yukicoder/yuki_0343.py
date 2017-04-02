from fractions import Fraction

N = int(raw_input())
L = int(raw_input())
A = [0]
for i in xrange(N-1):
    A.append(int(raw_input()))

for i in xrange(N-1):
    l1, r1 = A[i], A[i]+L
    l2, r2 = A[i+1], A[i+1]+L
    if r2 <= l1 or r1 <= l2:
        print -1
        exit()

s = 0
ans = 0
for i in xrange(N-1):
    s += Fraction(A[N-i-1] + A[N-i-1] + L, 2)
    ave = Fraction(s, i + 1)
    if (A[N-i-1] < ave < A[N-i-1] + L and
        A[N-i-2] < ave < A[N-i-2] + L):
        pass
    else:
        ans += 1
print ans

