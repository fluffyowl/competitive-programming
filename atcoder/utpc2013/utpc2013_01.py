s = raw_input()
ana = 'ADOPQRB'
print 'yes' if s[0] not in ana and s[1] not in ana and s[3] not in ana and s[2] in ana and s[2] != 'B' else 'no'
