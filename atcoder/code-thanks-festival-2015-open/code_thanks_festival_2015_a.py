a = int(raw_input())
b = int(raw_input())
if a*b <= 0:
    print abs(a)*2 + abs(b)*2
else:
    print max(abs(a), abs(b)) * 2
