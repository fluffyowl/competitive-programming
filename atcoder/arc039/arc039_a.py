A, B = raw_input().split()
altA, altB = A, B
if A[0] != '9':
    altA = '9' + A[1] + A[2]
elif A[1] != '9':
    altA = A[0] + '9' + A[2]
elif A[2] != '9':
    altA = A[0] + A[1] + '9'
if B[0] != '1':
    altB = '1' + B[1] + B[2]
elif B[1] != '0':
    altB = B[0] + '0' + B[2]
elif B[2] != '0':
    altB = B[0] + B[1] + '0'
print max(int(altA)-int(B), int(A)-int(altB))
