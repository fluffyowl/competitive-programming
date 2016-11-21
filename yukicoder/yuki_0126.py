a, b, s = map(int, raw_input().split())
if a == -1:
    a = 0

if s == 1:
    print abs(s-a)+1
elif abs(s-a) <= abs(s-b):
    print abs(s-a)+s
else:
    print abs(s-b) + min(abs(s-a)+a+(a==0),
                         s-1 + abs(a-1) + 1)

