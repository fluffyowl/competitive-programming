import itertools 
S, N = raw_input(), int(raw_input())
print ''.join(list(itertools.product(S, S))[N-1])
