d = {'b':'d', 'd':'b', 'p':'q', 'q':'p'}
S = raw_input()
T = ''.join(map(lambda x:d[x], list(S[::-1])))
print 'Yes' if S == T else 'No'
