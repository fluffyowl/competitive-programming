S = raw_input()
A = int(S[:2])
L = len(S) - 1
if int(S[2]) >= 5:
    A += 1
    if len(str(A)) > len(str(A-1)):
        L += 1
print str(A)[0] + "." + str(A)[1] + "*10^" + str(L)

