a, b = map(int, raw_input().split())

stack = [(a, b)]
d = set()
while len(stack) > 0:
    x, y = stack[-1]
    stack.pop()
    if x == 0 or y == 0:
        print "Yes"
        exit()
    if (x, y) in d:
        continue
    if x % 2 == 1 and y % 2 == 1:
        continue
    d.add((x, y))
    if y > 0 and x % 2 == 0:
        xx = x / 2
        yy = y - 1
        if (xx, yy) not in d:
            stack.append((xx, yy))
    if x > 0 and y % 2 == 0:
        xx = x - 1
        yy = y / 2
        if (xx, yy) not in d:
            stack.append((xx, yy))

print "No"

