ok = lambda s: s.isdigit() and len(s) == len(str(int(s))) and 0 <= int(s) <= 12345
print 'OK' if ok(raw_input()) and ok(raw_input()) else 'NG'

