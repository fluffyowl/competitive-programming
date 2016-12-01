A, B, C = map(int, raw_input().split())
if A+B==C and A-B==C:
    print '?'
elif A+B == C:
    print '+'
elif A-B == C:
    print '-'
else:
    print '!'
