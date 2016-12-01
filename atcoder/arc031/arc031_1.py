s = raw_input()
print 'YES' if all(map(lambda x:x[0]==x[1], [(s[i], s[-i-1]) for i in range(len(s)/2)])) else 'NO'
