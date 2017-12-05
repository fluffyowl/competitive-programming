S = raw_input()
A = 'AKIHABARA'
used = False
p = 0

for i in xrange(len(A)):
    if p < len(S) and S[p] == A[i]:
        p += 1
        used = False
    elif not used and A[i] == 'A':
        used = True
    else:
        print 'NO'
        exit()

if p == len(S):
    print 'YES'
else:
    print 'NO' S = raw_input()
A = 'AKIHABARA'
used = False
p = 0

for i in xrange(len(A)):
    if p < len(S) and S[p] == A[i]:
        p += 1
        used = False
    elif not used and A[i] == 'A':
        used = True
    else:
        print 'NO'
        exit()

if p == len(S):
    print 'YES'
else:
    print 'NO'
