ax, ay = 2, 8
bx, by = 3, 9
cx, cy = 7, 9

n = int(input())

for _ in range(n):
    x1, y1, x2, y2 = map(int, input().split())
    if x1 == ax and y1 == ay:
        ax, ay = x2, y2
    elif x1 == bx and y1 == by:
        bx, by = x2, y2
    elif x1 == cx and y1 == cy:
        cx, cy = x2, y2

print ("YES" if ax == 5 and ay == 8 and bx == 4 and by == 8 and cx == 6 and cy == 8 else "NO")

