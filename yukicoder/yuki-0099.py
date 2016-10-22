input()
x = map(int, raw_input().split())
print abs(len(filter(lambda a:a%2, x)) - len(filter(lambda a:a%2==0, x)))

