bucket = [[[] for i in range(10)] for i in range(10)]
b = map(int, raw_input().split())
for i in range(input()):
    d = raw_input()
    bucket[0][int(d[-1])].append(d)

for i in range(1, 9):
    for j in b:
        for d in bucket[i-1][j]:
            if len(d) <= i:
                bucket[i][0].append(d)
            else:
                bucket[i][int(d[-i-1])].append(d)

for i in b:
    for d in bucket[8][i]:
        print d
