import re

N = input()
for i in xrange(N):
    S = raw_input()
    R = re.findall('[0-9]+', S)
    if len(R) == 0:
        print S
    else:
        T = R[-1]
        I = S.rfind(T)
        L = len(T)
        if T[0] == '0':
            X = str(int(T) + 1)
            X = '0' * (L - len(X)) + X
            print S[:I] + X + S[I+L:]
        else:
            X = str(int(T) + 1)
            print S[:I] + X + S[I+L:]

