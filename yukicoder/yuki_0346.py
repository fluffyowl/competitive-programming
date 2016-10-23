S = raw_input()
c_index = [i for i in xrange(len(S)) if S[i] == 'c']
w_index = [i for i in xrange(len(S)) if S[i] == 'w']
if len(c_index) == 0 or len(w_index) == 0:
    print 0
    exit()
wp = 0
ans = 0
for c in c_index:
    if wp >= len(w_index):
        break
    while w_index[wp] < c:
        wp += 1
        if wp >= len(w_index):
            break
    ans += (len(w_index)-wp)*(len(w_index)-wp-1)/2
print ans
