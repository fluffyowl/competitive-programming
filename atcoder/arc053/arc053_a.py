def input_to_int():
    return map(int, raw_input().split())
H, W = input_to_int()
print (H-1)*W + (W-1)*H
