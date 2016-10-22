N = raw_input()
M = raw_input()

if int(N)%int(M) == 0:
    print filter(lambda c:c!='0', str(int(N)/int(M)))[-1]
    exit()
L = int(M)
while L > 1:
    if L % 2 == 0:
        L /= 2
    elif L % 5 == 0:
        L /= 5
    else:
        print -1
        exit()

A = 0
i = 0
M = int(M)
while True:
    if i < len(N):
        A = A*10 + int(N[i])
    else:
        A *= 10
    C, A = A/M, A%M
    if C != 0:
        B = C
    if (A == 0) and i >= len(N)-1:
        print B
        break
    i += 1

