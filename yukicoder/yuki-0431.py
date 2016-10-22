a,b,c,d = map(int, raw_input().split())
print ['DEAD','SURVIVED'][(a+b+c<2)or d>0]

