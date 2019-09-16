N = input()
S = ""
for i in xrange(1, 1000):
    if len(S) > N:
        break
    S += str(i)

print S[N-1]

