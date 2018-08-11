A = int(raw_input())
S = raw_input()

if A == 0:
    print "Yes"
    exit()

for c in S:
    if c == '+':
        A += 1
    else:
        A -= 1
    if A == 0:
        print "Yes"
        exit()

print "No"
