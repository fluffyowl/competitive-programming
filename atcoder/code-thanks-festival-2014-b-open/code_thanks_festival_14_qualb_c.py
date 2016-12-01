input()
v = map(int, raw_input().split())
f = map(int, raw_input().split())
print sum(map(lambda x:x[1]*2>x[0], zip(v, f)))
