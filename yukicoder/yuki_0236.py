X, Y, A, B = map(float, raw_input().split())
a = B*X/Y
b = A*Y/X
if a > A:
    print A+b
elif b > B:
    print a+B
else:
    print max(A+b, a+B)

