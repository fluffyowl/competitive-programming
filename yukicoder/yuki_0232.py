T, A, B = map(int, raw_input().split())
ans = []
a, b = 0, 0

if A == B == 0:
    if T == 1:
        print 'NO'
        exit()
    else:
        b -= 1
        T -= 1
        ans.append('<')

if max(A, B) > T:
    print 'NO'
    exit()

while A-a > 1 or B-b > 1:
    arrow = ''
    if A-a > 0:
        a += 1
        arrow += '^'
    if B-b > 0:
        b += 1
        arrow += '>'
    ans.append(arrow)
    T -= 1

if T == 1:
    aaa = ''
    if A-a > 0:
        aaa += '^'
    if B-b > 0:
        aaa += '>'
    ans.append(aaa)
    print 'YES'
    for a in ans:
        print a
    exit()
    
if A == B and B != 0:
    T -= 1
    ans.append('^')
if A > B:
    T -= 1
    ans.append('^<')
while T > 2:
    ans.append('^')
    ans.append('v')
    T -= 2
if T == 2:
    ans.append('^')
    ans.append('v>')
else:
    ans.append('>')

print 'YES'
for a in ans:
    print a

