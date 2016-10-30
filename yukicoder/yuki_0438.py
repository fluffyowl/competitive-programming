x, y, z = map(int, raw_input().split())
if z == 0:
    print 'ccW'
    exit()

def print_ans(a, b, w):
    if a >= 0 and b < 0:
        ans = ('w'*abs(b) + 'c'*abs(a) + 'C'*(abs(a)-1) + 'W'*abs(b))*w+'C'*(w-1)
    elif a < 0 and b >= 0:
        ans = ('c'*abs(a) + 'w'*abs(b) + 'C'*(abs(b)-1) + 'W'*abs(a))*w+'C'*(w-1)
    else:
        ans = ('c'*abs(a) + 'w'*abs(b) + 'C'*(abs(a)+abs(b)-1))*w+'C'*(w-1)
    if len(ans) <= 10000:
        print ans
        exit()
    else:
        return

for a in xrange(-5000, 5001):
    for b in xrange(-5000, 5001):
        c = a*x+b*y
        if c > 0 and z % c == 0:
            if a != 0 or b != 0:
                if 2*(abs(a)+abs(b)-2)*z/c + z/c-1 <= 10000:
                    print_ans(a, b, z/c)
print 'mourennaihasimasenn'

