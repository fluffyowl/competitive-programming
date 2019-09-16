N = raw_input()
S = ""

for i in xrange(len(N)-1, -1, -1):
    S += str(N[i])
    if i != 0 and (len(N)-i) % 3 == 0:
        S += ","

T = ""
for i in xrange(len(S)-1,-1,-1):
    T += S[i]

print T

