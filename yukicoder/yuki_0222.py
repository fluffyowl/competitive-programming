import re
s = raw_input()
nums = re.findall('\d+', s)
ops = re.split('\d+', s)
ans = int(ops[0]+nums[0])
if len(ops[1]) == 1:
    if ops[1] == '-':
        ans += int(nums[1])
    else:
        ans -= int(nums[1])
elif ops[1][0] == '+':
    ans -= int(ops[1][1]+nums[1])
else:
    ans += int(ops[1][1]+nums[1])
print ans

