S = raw_input()
stack = [(S,'')]
result = set()
while len(stack) > 0:
    a, b = stack.pop()
    if a == '':
        result.add(b)
    else:
        stack.append((a[1:], b+a[0]))
        stack.append((a[:-1], b+a[-1]))
print len(result)

