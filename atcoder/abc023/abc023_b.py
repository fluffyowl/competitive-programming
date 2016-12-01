N = int(raw_input())
S = raw_input()

if N%2 == 0:
    print -1
    exit()

os = 'b'

for i in range(1, N/2+1):
    if i % 3 == 1:
        os = 'a' + os + 'c'
    elif i % 3 == 2:
        os = 'c' + os + 'a'
    else:
        os = 'b' + os + 'b'

if S == os:
    print N/2
else:
    print -1
