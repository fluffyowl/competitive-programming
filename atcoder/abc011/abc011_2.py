s = raw_input()
print s.upper() if len(s)==1 else s[0].upper()+s[1:].lower()
