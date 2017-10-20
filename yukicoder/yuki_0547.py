N = input()
S = raw_input().split()
T = raw_input().split()
for i in xrange(N):
    if S[i] != T[i]:
        print i + 1
        print S[i]
        print T[i]
        break

