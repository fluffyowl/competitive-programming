H, W = map(int, raw_input().split())

if H > W:
    H, W = W, H

if H == 1 and W == 1:
    print 1
elif H == 1:
    print W - 2
else:
    print (H - 2) * (W - 2)
