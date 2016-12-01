a, b = map(lambda x:abs(int(x)), raw_input().split())
if a != b:
    print 'Ant' if a < b else 'Bug'
else:
    print 'Draw'
