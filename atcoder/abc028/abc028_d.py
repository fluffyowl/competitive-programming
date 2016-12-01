from fractions import Fraction

def input_to_int():
    return map(int, raw_input().split())

N, K = input_to_int()

p_K = Fraction(1, N)
p_K_less = Fraction(K-1, N)
p_K_greater = Fraction(N-K, N)

chigau = p_K * p_K_less * p_K_greater * 6
futatsu = p_K * p_K * Fraction(N-1, N) * 3
mittsu = p_K * p_K * p_K

print float(chigau+futatsu+mittsu)
