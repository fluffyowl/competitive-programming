A = raw_input().split()
B = raw_input().split()
a = 180 - int(A[1]) if A[0] == 'W' else int(A[1]) + 180
b = 180 - int(B[1]) if B[0] == 'W' else int(B[1]) + 180
print abs(b - a)/15
