x1, y1 = map(float, raw_input().split())
x2, y2 = map(float, raw_input().split())
print '%.7f'%((y2-y1)/(-x2-x1)*(-x1)+y1)

