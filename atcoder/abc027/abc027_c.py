N=int(raw_input())
s, e = N/2 + 1, N
turn = 'WIN'
if N <= 1:
    print 'Aoki'
    exit()
while True:
    if turn == 'WIN':
        if s == 2 or s == 3:
            print 'Takahashi'
            break
        s /= 2
        turn = 'LOSE'
    elif turn == 'LOSE':
        if s == 2:
            print 'Aoki'
            break
        s = s / 2 + s % 2
        turn = 'WIN'
