input()
s=raw_input()
print sum(s.count(x)%2 for x in 'RGB')
