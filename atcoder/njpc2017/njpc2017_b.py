H, W, N = map(int, raw_input().split())
yoko = set()
tate = set()
for i in xrange(N):
    r, c = map(int, raw_input().split())
    if H == 1:
        pass
    elif r == 1:
        tate.add((1, c))
    elif 1 < r < H:
        tate.add((r-1, c))
        tate.add((r, c))
    else:
        tate.add((r-1, c))

    if W == 1:
        pass
    elif c == 1:
        yoko.add((r, 1))
    elif 1 < c < W:
        yoko.add((r, c-1))
        yoko.add((r, c))
    else:
        yoko.add((r, c-1))

print (H-1)*W - len(tate) + H*(W-1) - len(yoko)
