d = {'BEGINNING':0, 'MIDDLE':lambda n:n/2, 'END':-1}
a = ''
for i in range(input()):
    s = raw_input().split()
    if s[0] == 'BEGINNING':
        a += s[2][0]
    elif s[0] == 'MIDDLE':
        a += s[2][len(s[2])/2]
    else:
        a += s[2][-1]
print a
