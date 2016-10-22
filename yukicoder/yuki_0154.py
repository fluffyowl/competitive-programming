def solve(s):
    numG, numR = s.count('G'), s.count('R')
    if numG != numR or numG == 0:
        return False
    W, G, R = 0, 0, 0
    Wassign = 0
    for light in s:
        if light == 'R':
            R += 1
        elif light == 'G':
            G += 1
            Wassign += 1
        else:
            W += 1
            Wassign = max(Wassign-1, 0)
        if (R == 0 or G == 0) and W > 0:
            return False
        if G > R:
            return False
    if Wassign > 0:
        return False
    if G == numG and R == numR and W >= numG:
        return True
    else:
        return False

for t in xrange(input()):
    print 'possible' if solve(raw_input()[::-1]) else 'impossible'

