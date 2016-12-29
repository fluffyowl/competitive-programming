x, y = map(int, raw_input().split())
if x * y == 0 and x >= y:
    print x - y + 1
elif x * y == 0 and x < y:
    print y - x
elif x*y > 0 and x <= y:
    print y - x
elif x*y > 0 and x > y:
    print x - y + 2
else:
    print abs(abs(y) - abs(x)) + 1
