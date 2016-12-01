raw_input()
s = raw_input().lower()
for a, b in (zip('bcdfghjklmnpqrstvwxz',
                 '11249838579740635260')):
    s = s.replace(a, b)
for a in 'aiueoy,.':
    s = s.replace(a, '')
print ' '.join(s.split())
