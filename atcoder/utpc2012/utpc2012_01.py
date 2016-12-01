a = raw_input().split('/')
print ['no','yes'][sorted(a[0]) == sorted(a[1]+a[2])]
