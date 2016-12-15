N = input()
A = [int(raw_input()) for _ in xrange(N)]
 
last_red = -1
last_black = -1
longest = [-1 for _ in xrange(N)]
 
for i in xrange(2*N):
    i = i % N
    if A[i] == 0:
        last_black = i
    elif A[i] == 1:
        last_red = i
    if (last_red != -1 and last_black != -1):
        d = abs(last_black-last_red)
        longest[i] = min(d, N-d)
 
last_red = -1
last_black = -1        
for i in xrange(2*N):
    i = (2*N - i)%N
    if A[i] == 0:
        last_black = i
    elif A[i] == 1:
        last_red = i
    if (last_red != -1 and last_black != -1):
        d = abs(last_black-last_red)
        longest[i] = min(longest[i], min(d, N-d))
 
print max(longest)
