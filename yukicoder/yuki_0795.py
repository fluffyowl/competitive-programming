A = input()
B = input()

A %= 2

if A > 0 and B < 10:
    print "No"
    exit()

print "Yes" if B % 2 == 0 else "No"
