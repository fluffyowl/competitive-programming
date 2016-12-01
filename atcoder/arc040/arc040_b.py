N, R = map(int, raw_input().split())
S = list(raw_input()) + ['o'] * (R+10)
for i in range(N-1, -1, -1):
    if S[i] == '.':
        last = i
        break
else:
    print 0
    exit()
 
t = 0
p = 0
while True:
    t += 1
    if p + R - 1 >= last:
        break
    if S[p] == '.':
        for i in range(R):
            S[p+i] = 'o'
    else:
        p += 1
 
print t
