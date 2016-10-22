x, y, m = input(), input(), input()
print (abs(x)+m-1)/m + (abs(y)+m-1)/m + (x!=0) + (x==0 and y<0) + (y<0)
