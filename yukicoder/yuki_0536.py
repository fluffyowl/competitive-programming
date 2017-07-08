S = raw_input()
if S.endswith('ai'):
    print S[:-2] + 'AI'
else:
    print S + '-AI'

