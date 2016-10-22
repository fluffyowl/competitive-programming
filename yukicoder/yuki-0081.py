N = input()
nums = []
for _ in xrange(N):
    s = raw_input().split('.')
    decimal = s[1] + '0'*(10-len(s[1])) if len(s) > 1 else '0'*10
    nums.append(int((s[0]+decimal)))
s = str(sum(nums))
print s[:-10] + '.' + s[-10:]

