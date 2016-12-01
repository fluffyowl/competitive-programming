L, H = map(int, raw_input().split())
for i in range(int(raw_input())):
    a = int(raw_input())
    if a <= L:
        print L-a
    elif a <= H:
        print 0
    else:
        print -1
