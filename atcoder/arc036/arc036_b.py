N = int(raw_input())
h = []
ha = h.append
for i in range(N):
    ha(int(raw_input()))

if N == 1:
    print 1
    exit()
    
ans = float('-inf')
s = 0
if h[0] < h[1]:
    mode = 'UP'
else:
    mode = 'DOWN'
    
for i in range(2, N):
    if h[i-1] < h[i] and mode == 'DOWN':
        mode = 'UP'
        ans = max(ans, i-1-s+1)
        s = i-1
    elif h[i-1] > h[i]:
        mode = 'DOWN'
ans = max(ans, N-1-s+1)
print ans
