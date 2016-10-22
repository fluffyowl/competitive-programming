input()
s = map(int,raw_input().split())
print sum([30 for a in s if a*10<=sum(s)])

