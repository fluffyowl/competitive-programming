from string import ascii_lowercase

N = input()
S = ''
alp = 'vwxyz'

N -= 1
S += 'a'
i = 3
while i <= N:
    S += 'ba'
    N -= i
    i += 2
if N > 0:
    N -= 1
    S += 'c'
    i = 3
    while i <= N:
        S += 'dc'
        N -= i
        i += 2
for i in xrange(N):
    S += alp[i%5]
        
print S
    

