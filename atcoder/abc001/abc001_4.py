# -*- coding:utf-8 -*-

import operator

def input_to_int():
    return raw_input().split('-')
 
def kirisute(t):
    if t[3] == '0' or t[3] == '5':
        return t
    return t[0:3]+'0' if t[3] < '5' else t[0:3]+'5'
 
def kiriage(t):
    if t[3] == '0' or t[3] == '5':
        return t
    t = t[0:3]+'5' if t[3] < '5' else t[0:3]+'0'
    if t[2:] == '50':
        t = str(int(t[0:2])+1).zfill(2) + '00'
    elif t[3] == '0':
        t = t[0:2] + str(int(t[2])+1) + '0'
    return t
 
N = int(raw_input())
times = []
for i in range(N):
    times.append(input_to_int())
    times[-1] = (kirisute(times[-1][0]), kiriage(times[-1][1]))
times = sorted(times, key=lambda x: int(x[0]))
#times.sort(key=lambda x: int(x), operator.itemgetter(0))

start, end = None, None
last_print = None
for s, e in times:
    if end is None:
        start, end = s, e
    elif int(s) > int(end):
        last_print = (start, end)
        print start+'-'+end
        start, end = s, e
    elif int(e) > int(end):
        end = e
if (start, end) != last_print:
    print start+'-'+end
