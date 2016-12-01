a = []
for i in range(3):
    a.append(int(raw_input()))
for i in range(3):
    if a[i] == max(a):
        print 1
    elif a[i] == min(a):
        print 3
    else:
        print 2
