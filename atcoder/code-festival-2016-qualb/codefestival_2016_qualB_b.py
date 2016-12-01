N, A, B = map(int, raw_input().split())
a, b = 0, 0
for s in raw_input():
    if s == 'a' and a+b < A+B:
        print 'Yes'
        a += 1
    elif s == 'b' and a+b < A+B and b < B:
        print 'Yes'
        b += 1
    else:
        print 'No'
