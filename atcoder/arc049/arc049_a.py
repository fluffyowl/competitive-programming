S = raw_input()
A, B, C, D = map(int, raw_input().split())
print S[:A] + "\"" + S[A:B] + "\"" + S[B:C] + "\"" + S[C:D] + "\"" + S[D:]
