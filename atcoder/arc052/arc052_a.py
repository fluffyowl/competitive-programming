import re
pattern = r'\d+'
S = raw_input()
print re.findall(pattern, S)[0]
