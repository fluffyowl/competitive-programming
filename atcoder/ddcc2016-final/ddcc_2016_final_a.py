R, C = map(int, raw_input().split())
ans = 0

for x in xrange(-R/C*C-2*C, R/C*C+2*C+1, C):
    for y in xrange(-R/C*C-2*C, R/C*C+2*C+1, C):
        if x*x + y*y <= R*R and x != 0 and y != 0:
            ans += 1

print ans
