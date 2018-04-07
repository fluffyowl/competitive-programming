N = input()
M = N * 6 / 10
H = M / 60
M %= 60
M = '0' + str(M) if M < 10 else str(M)
print str(H+10) + ':' + str(M)

