s = raw_input()
for i in range(len(s)/2):
    if not (s[i] == s[-i-1] or s[i] == '*' or s[-i-1] == '*'):
        print 'NO'
        exit()
print 'YES'
