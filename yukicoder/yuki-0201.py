a = raw_input().split()
b = raw_input().split()
if int(a[1]) > int(b[1]):
    print a[0]
elif int(a[1]) == int(b[1]):
    print -1
else:
    print b[0]

