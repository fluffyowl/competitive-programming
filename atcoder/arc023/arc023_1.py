y=input()
m=input()
d=input()
if m <= 2:
    m = 12+m
    y -= 1
print 735369 - (365*y+y/4-y/100+y/400+306*(m+1)/10+d-429)
