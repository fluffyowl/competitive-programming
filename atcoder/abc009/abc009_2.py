n = int(raw_input())
p = []
for i in range(n):
    p.append(int(raw_input()))
print sorted(list(set(p)))[-2]
