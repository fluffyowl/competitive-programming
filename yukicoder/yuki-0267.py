N = input()
c = raw_input().split()
ans = []

for m in ['D', 'C', 'H', 'S']:
    for n in ['A', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K']:
        if m+n in c:
            ans.append(m+n)
print ' '.join(ans)

