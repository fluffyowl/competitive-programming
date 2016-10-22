N = input()
a = map(int, raw_input().split())
b = [sum(a)/(N-1)-x for x in a]
print b.count(2), b.count(4)

