stacks = []
for i in range(input()):
    b = input()
    for j in range(len(stacks)):
        if stacks[j] >= b:
            stacks[j] = b
            break
    else:
        stacks.append(b)
print len(stacks)
