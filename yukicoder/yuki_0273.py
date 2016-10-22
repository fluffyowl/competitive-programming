def kaibun(s):
    for i in xrange(len(s)/2):
        if s[i] != s[-i-1]:
            return False
    return True

S = raw_input()
N = len(S)

for keta in xrange(N-1, 0, -1):
    for i in xrange(N-keta+1):
        if kaibun(S[i:i+keta]):
            print keta
            exit()
            

