import sys


q = input()
for i in xrange(q):
    x1, x2, y1, y2 = map(int, raw_input().split())
    print "SELECT count(*) FROM point WHERE x>=%d AND x<=%d AND y>=%d AND y<=%d;"%(x1, x2, y1, y2)
    sys.stdout.flush()

