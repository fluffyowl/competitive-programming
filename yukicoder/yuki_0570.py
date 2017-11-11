A = []
A.append((int(raw_input()), 'A'))
A.append((int(raw_input()), 'B'))
A.append((int(raw_input()), 'C'))
A.sort(key=lambda x: -x[0])
for a in A:
    print a[1]

