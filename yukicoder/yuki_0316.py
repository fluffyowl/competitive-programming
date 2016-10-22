from fractions import gcd
lcm = lambda x,y:x*y/gcd(x,y)
n = input()
a, b, c = map(int, raw_input().split())
print n/a+n/b+n/c-n/lcm(a,b)-n/lcm(b,c)-n/lcm(c,a)+n/(lcm(lcm(a,b),c))
