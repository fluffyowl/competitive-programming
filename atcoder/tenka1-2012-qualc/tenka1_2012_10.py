import re

s = raw_input()
pattern = r'[SCHD][JQKA]|[SCHD]\d+'
cards = re.findall(pattern, s)

a = {'S':0, 'C':0, 'H':0, 'D':0}
for i, c in enumerate(cards):
    if c[1:] in ('10JQKA'):
        a[c[0]] += 1
        if a[c[0]] == 5:
            m = i
            mark = c[0]
            break

ans = ''
for i in range(m):
    c = cards[i]
    if c[0] == mark and c[1:]  in '10JQKA':
        continue
    ans += c
print ans if ans != '' else 0
