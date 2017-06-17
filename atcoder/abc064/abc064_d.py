N = input()
S = raw_input()

l, r = 0, 0
tmp = 0
for i in xrange(N):
    if S[i] == '(':
        tmp += 1
    else:
        tmp -= 1
        if tmp < 0:
            l += 1
            tmp = 0

tmp = 0
for i in xrange(N-1, -1, -1):
    if S[i] == ')':
        tmp += 1
    else:
        tmp -= 1
        if tmp < 0:
            r += 1
            tmp = 0
print '(' * l + S + ')' * r
