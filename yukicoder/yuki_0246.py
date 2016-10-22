import sys

high = 10**9
low = 1
while high-low > 1:
    middle = (high+low)/2
    print "? %d" % middle
    sys.stdout.flush()
    if int(raw_input()) == 1:
        low = middle
    else:
        high = middle

print "? %d" % low
sys.stdout.flush()
print "! %d" % low if int(raw_input()) == 1 else "! %d" % high
sys.stdout.flush()

