n,m=map(int,raw_input().split())
print sum(i*i for i in range(1,n+1))%m
