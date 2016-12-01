a, s, t = input(), raw_input(), raw_input()
for i in xrange(a):
    if s[i:] == t[:a-i]:
        print a+i
        exit()
print a*2
