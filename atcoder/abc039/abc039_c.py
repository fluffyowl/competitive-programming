S = raw_input()
a = 'WBWBWWBWBWBWWBWBWWBWBWBWWBWBWWBWBWBWWBWBWWBWBWBWWBWBWWBWBWBWWBWBWWBWBWBWWBWBWWBWBWBWWBWBWWBWBWBWWBWBWWBWBWBWWBWBWWBWBWBW'
b = ['Do', 'Re', 'Mi', 'Fa', 'So', 'La', 'Si']
for i, j in enumerate([0, 2, 4, 5, 7, 9, 11]):
    if a[j:j+20] == S:
        print b[i]
        break
