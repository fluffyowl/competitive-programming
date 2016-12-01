n = input()
for i in range(1, 101):
    if i*i*i == n:
        print 'YES'
        break
else:
    print 'NO'
