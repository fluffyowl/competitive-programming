def ok(S):
    if S[0] == '-':
        A = S[1:]
    else:
        A = S[:]
    return A[0] != '-' and A[0] >= '1' and A[0] <= '9' and len(A) >= 3 and set(A[1:]) == set(['0'])

A, B = raw_input().split()
if ok(A) and ok (B):
    AB = str(int(A) * int(B))
    print AB[:-1]
else:
    AB = int(A) * int(B)
    if AB < -99999999 or AB > 99999999:
        print 'E'
    else:
        print AB

