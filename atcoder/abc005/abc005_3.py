T = int(raw_input())
N = int(raw_input())
a = map(int, raw_input().split())
M = int(raw_input())
b = map(int, raw_input().split())

a_pointer = 0
b_pointer = 0

while True:
    if a_pointer >= len(a):
        print 'no'
        break
    if b[b_pointer] - a[a_pointer] > T:
        a_pointer += 1
        continue
    if b[b_pointer] - a[a_pointer] < 0:
        a_pointer += 1
        continue
    a_pointer += 1
    b_pointer += 1
    if b_pointer >= len(b):
        print 'yes'
        break
