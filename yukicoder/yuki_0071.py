N=input()
print max((N-d)*(d+1)+d for d in range(1,N+1))
