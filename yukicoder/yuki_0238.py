def is_kaibun(s):
    return all(s[i]==s[-i-1] for i in xrange(len(s)/2))

S = raw_input()
if is_kaibun(S):
    m = len(S)/2
    print S[:m]+S[m]+S[m:]
    exit()
for i in xrange(len(S)/2):
    j = len(S)-i-1
    if S[i] != S[j]:
        T = S[:i]+S[j]+S[i:]
        if is_kaibun(T):
            print T
            exit()
        T = S[:i+1]+S[j]+S[i+1:]
        if is_kaibun(T):
            print T
            exit()
        T = S[:j]+S[i]+S[j:]
        if is_kaibun(T):
            print T
            exit()
        T = S[:j+1]+S[i]+S[j+1:]
        if is_kaibun(T):
            print T
            exit()
        print 'NA'
        exit()
print 'NA'
