print ''.join([chr((ord(c)-ord('A')-i-1)%26+ord('A')) for i, c in enumerate(raw_input())])

