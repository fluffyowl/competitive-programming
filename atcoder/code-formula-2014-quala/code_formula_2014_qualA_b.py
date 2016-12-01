S = '7 8 9 0\n 4 5 6\n  2 3\n   1'
raw_input()
for s in raw_input().split():
    S = S.replace(s, '.')
for s in raw_input().split():
    S = S.replace(s, 'o')
for s in '1234567890':
    S = S.replace(s, 'x')
print S
