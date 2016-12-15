import re

S = raw_input().replace('25', 'a')
S = re.sub('[0-9]', ' ', S).split()
print sum(map(lambda x:len(x)*(len(x)+1)/2, S))
