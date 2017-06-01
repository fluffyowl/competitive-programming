N = input()
A = [raw_input() for _ in xrange(N)]
M = input()
B = [raw_input() for _ in xrange(M)]

if N == 1:
    print A[0]
    exit()
if M == 1:
    print B[0]
    exit()

first = set([a[0] for a in A]) & set([b[0] for b in B])
if len(first) > 1:
    print -1
    exit()
last = first.pop()
ans = last

while len(A) > 0 or len(B) > 0:
    for i in xrange(len(A)):
        if last in A[i]:
            j = A[i].find(last)
            ans += A[i][j+1:]
            last = A[i][-1]
            A.pop(i)
            break
        if A[i] in ans:
            A.pop(i)
            break
    for i in xrange(len(B)):
        if last in B[i]:
            j = B[i].find(last)
            ans += B[i][j+1:]
            last = B[i][-1]
            B.pop(i)
            break
        if B[i] in ans:
            B.pop(i)
            break

print ans

