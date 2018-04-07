H, M, S = raw_input().split()
H = int(H) - 9
H %= 24
M = int(M)
S = S[3:].split('.')
sign = S[0][0]
A = int(S[0])
B = 0 if len(S) <= 1 else int(S[1])
if sign == '-':
    B *= -1
B = B * 6

H += A
M += B

while M >= 60:
    M -= 60
    H += 1
while M < 0:
    M += 60
    H -= 1

H %= 24
H = '0' + str(H) if H < 10 else str(H)
M = '0' + str(M) if M < 10 else str(M)

print str(H) + ':' + str(M)

