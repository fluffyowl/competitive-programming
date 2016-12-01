s = raw_input()
print 'No' if (('N' in s) ^ ('S' in s)) or (('W' in s) ^ ('E' in s)) else 'Yes'
