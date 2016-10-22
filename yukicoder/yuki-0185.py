N = input()
A = [map(int, raw_input().split()) for _ in xrange(N)]
A = [b-a for a, b in A]
print A[0] if all(A[0]==a for a in A) and A[0]>0 else -1

