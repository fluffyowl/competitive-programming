N = input()
C = raw_input().split()

ops = sorted([s for s in C if s in '+-'])
nums = sorted([s for s in C if s not in '+-'])

maximum = []
for i in xrange(len(nums)):
    maximum.append(nums[i])
    if i < len(ops):
        maximum.append(ops[-i-1])

if all(op == '+' for op in ops):
    L = [[] for _ in xrange(len(ops)+1)]
    for i, n in enumerate(nums):
        L[i%(len(ops)+1)].append(n)
    minimum = sum(int(''.join(l)) for l in L)
else:
    minimum = []
    for i in xrange(len(ops)):
        minimum.append(nums[i])
        minimum.append(ops[i])
    for i in xrange(len(nums)-len(ops)):
        minimum.append(nums[-i-1])
    minimum = eval(''.join(minimum))

maximum = eval(''.join(maximum[::-1]))
print maximum, minimum

