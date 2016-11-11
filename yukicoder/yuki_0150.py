def solve():
    S = raw_input()
    ans = float('inf')
    for i in xrange(len(S)-10):
        good = (S[i]!='g')+(S[i+1]!='o')+(S[i+2]!='o')+(S[i+3]!='d')
        for j in xrange(i+4, len(S)-6):
            problem = (S[j] != 'p') + (S[j+1] != 'r') + (S[j+2] != 'o') + (S[j+3] != 'b') +\
                      (S[j+4] != 'l') + (S[j+5] != 'e') + (S[j+6] != 'm')
            ans = min(ans, good+problem)
    print ans
    
for _ in xrange(input()):
    solve()

