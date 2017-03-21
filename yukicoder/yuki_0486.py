s = raw_input()
o = s.find('OOO')
x = s.find('XXX')
if o == -1 and x == -1:
    print "NA"
elif o == -1:
    print "West"
elif x == -1:
    print "East"
else:
    print "East" if o < x else "West"

