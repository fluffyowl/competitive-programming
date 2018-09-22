N = input()
if N  == 0:
    print 0
elif N > 0:
    A = []
    B = []
    carry = 0
    cnt = 0
    while N > 0:
        if cnt == 0:
            B.append(0)
            if N % 2 == 1 and carry == 0:
                A.append(1)
            elif N % 2 == 1 and carry == 1:
                A.append(0)
            elif N % 2 == 0 and carry == 0:
                A.append(0)
            elif N % 2 == 0 and carry == 1:
                A.append(1)
                carry = 0
        else:
            A.append(0)
            if N % 2 == 1 and carry == 0:
                B.append(1)
                carry = 1
            elif N % 2 == 1 and carry == 1:
                B.append(0)
            elif N % 2 == 0 and carry == 0:
                B.append(0)
            elif N % 2 == 0 and carry == 1:
                B.append(1)
        N /= 2
        cnt ^= 1
    if carry:
        if cnt == 0:
            A.append(1)
            B.append(0)
        else:
            A.append(0)
            B.append(1)
            A.append(1)
            B.append(0)
    A.reverse()
    B.reverse()
    ans = []
    for a, b in zip(A, B):
        ans.append(a + b)
    print "".join(map(str, ans))
else:
    N *= -1
    A = []
    B = []
    carry = 0
    cnt = 0
    while N > 0:
        if cnt == 0:
            B.append(0)
            if N % 2 == 1 and carry == 0:
                A.append(1)
                carry = 1
            elif N % 2 == 1 and carry == 1:
                A.append(0)
            elif N % 2 == 0 and carry == 0:
                A.append(0)
            elif N % 2 == 0 and carry == 1:
                A.append(1)
        else:
            A.append(0)
            if N % 2 == 1 and carry == 0:
                B.append(1)
            elif N % 2 == 1 and carry == 1:
                B.append(0)
            elif N % 2 == 0 and carry == 0:
                B.append(0)
            elif N % 2 == 0 and carry == 1:
                B.append(1)
                carry = 0
        N /= 2
        cnt ^= 1
    if carry:
        if cnt == 1:
            B.append(1)
            A.append(0)
        else:
            B.append(0)
            A.append(1)
            B.append(1)
            A.append(0)
    A.reverse()
    B.reverse()
    ans = []
    for a, b in zip(A, B):
        ans.append(a + b)
    print "".join(map(str, ans))
