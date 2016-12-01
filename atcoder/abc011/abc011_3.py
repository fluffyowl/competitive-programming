n = int(raw_input())
ng1 = int(raw_input())
ng2 = int(raw_input())
ng3 = int(raw_input())
ngs = [ng1, ng2, ng3]

if 0 in ngs or n in ngs:
    print 'NO'
    exit()
    
left = 100
while True:
    if n <= 3 and left >= 1:
        print 'YES'
        exit()
    if left == 0:
        print 'NO'
        exit()
    if n-3 not in ngs:
        n -= 3
        left -= 1
    elif n-2 not in ngs:
        n -= 2
        left -= 1
    elif n-1 not in ngs:
        n -= 1
        left -=1
    else:
        print 'NO'
        exit()
