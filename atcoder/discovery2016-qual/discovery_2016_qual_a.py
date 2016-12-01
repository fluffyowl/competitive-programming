import sys
s = 'DiscoPresentsDiscoveryChannelProgrammingContest2016'
n = input()
for i, c in enumerate(s):
    sys.stdout.write(c)
    if (i+1)%n == 0:
        print
if len(s) % n != 0:
    print
