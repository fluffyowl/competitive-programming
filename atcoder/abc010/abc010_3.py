import math
x1, y1, x2, y2, T, V = map(int, raw_input().split())
TV = T*V
for i in range(int(raw_input())):
    x, y = map(int, raw_input().split())
    if math.sqrt((x-x1)**2+(y-y1)**2) + math.sqrt((x-x2)**2+(y-y2)**2) <= TV:
        print 'YES'
        exit()
print 'NO'
