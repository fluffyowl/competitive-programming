S = raw_input()
K = input()
M = ord('z')+1
ans = []
aa = ans.append
for s in S:
    o = ord(s)
    if s != 'a' and K>0 and M-o <= K:
        aa('a')
        K -= M-o
    else:
        aa(s)
if K > 0:
    K %= 26
    a = ord(ans[-1]) + K
    if a > ord('z'):
        a -= 26
    ans[-1] = chr(a)
print ''.join(ans)
