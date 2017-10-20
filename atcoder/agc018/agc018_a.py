from fractions import gcd

yes = "POSSIBLE"
no = "IMPOSSIBLE"

N, K = map(int, raw_input().split())
A = map(int, raw_input().split())

if N == 1:
    print yes if A[0] == K else no
    exit()

if K > max(A):
    print no
    exit()

g = reduce(gcd, A)
if g == 1:
    print yes
elif K % g == 0:
    print yes
else:
    print no
