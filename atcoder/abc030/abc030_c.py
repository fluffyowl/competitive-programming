N, M = map(int, raw_input().split())
X, Y = map(int, raw_input().split())
a = map(int, raw_input().split())
b = map(int, raw_input().split())

t = 0
a_pointer = 0
b_pointer = 0
position = 'a'
ans = 0

while True:
    if position == 'a':
        while t > a[a_pointer]:
            a_pointer += 1
            if a_pointer >= N:
                print ans
                exit()
        t = a[a_pointer] + X
        position = 'b'
    if position == 'b':
        while t > b[b_pointer]:
            b_pointer += 1
            if b_pointer >= M:
                print ans
                exit()
        t = b[b_pointer] + Y
        position = 'a'
        ans += 1
