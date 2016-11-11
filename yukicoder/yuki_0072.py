N = input()
d1 = (N-1)/2
d2 = (N-1)/2+1
print max((N-d1)*(d1+1)+d1, (N-d2)*(d2+1)+d2)%(10**6+7)

