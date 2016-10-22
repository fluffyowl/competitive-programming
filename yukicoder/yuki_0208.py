a, b = map(int, raw_input().split())
c, d = map(int, raw_input().split())
if a==b and c==d and a*c>0 and b*d>0 and a>c:
    print max(a, b)+1
else:
    print max(a, b)

