ans = 0
def parse(s):
    m, s = map(int, s.split(':'))
    return m*60+s
for _ in xrange(input()):
    s, g = map(parse, raw_input().split())
    ans += g-s if g>s else 1440-s+g
print ans
