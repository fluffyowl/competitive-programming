A = []
A.append([raw_input().split(), 'A'])
A.append([raw_input().split(), 'B'])
A.append([raw_input().split(), 'C'])
A.sort(key=lambda x: (-int(x[0][0]), int(x[0][1])))
for a in A:
    print a[1]

