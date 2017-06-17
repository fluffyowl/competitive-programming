m, s = map(int, raw_input().split(":"))
s += 5
if s >= 60:
    s = s % 60
    m += 1
    if m >= 24:
        m = 0
print "%02d:%02d" % (m, s)

