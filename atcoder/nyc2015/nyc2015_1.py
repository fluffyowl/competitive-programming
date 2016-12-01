s = bin(input())[2:]
for i in range(len(s)/2):
    if s[i] != s[-i-1]:
        print 'No'
        break
else:
    print 'Yes'
