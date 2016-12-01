from collections import Counter

s, t = raw_input(), raw_input()
if len(s) != len(t):
    print -1
    exit()

for i in xrange(len(s)):
    if s[-i:] + s[:-i] == t:
        print i
        exit()
print -1
