def count(s):
    counter = [0 for _ in xrange(26)]
    for c in s:
        counter[ord(c)-ord('a')] += 1
    return counter

N, K = map(int, raw_input().split())
S = raw_input()
unused = sorted(S)
T = ''

for i in xrange(N):
    for j in xrange(len(unused)):
        diff = N-i-1
        #print ''.join(map(str,unused[:j]+unused[j+1:])), count(unused[1:])
        #print S[i+1:], count(S[i+1:])
        for a, b in zip(count(unused[:j]+unused[j+1:]), count(S[i+1:])):
            diff -= min(a, b)
        diff += (unused[j] != S[i])
        if diff <= K:
            K -= (unused[j] != S[i])
            T += unused.pop(j)
        #    print T, unused, diff, K
            break
        else:
            continue
print T
