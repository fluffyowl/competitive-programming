raw_input()
a=map(int,raw_input().split())
s=0
for i in map(int,raw_input().split()):
    s+=a[i-1]
print s
