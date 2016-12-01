n = input()
m = n/10*10
print (m*10) + 15*(n-m) if n-m < 7 else (m*10) + 100
