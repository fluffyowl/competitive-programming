import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable int[] inv = [0, 1, 5, 0, 7, 2, 0, 4, 8];


void solve() {
    auto input = readln.split.map!(to!long);
    auto N = input[0].to!int;
    auto x = input[1];
    auto a = input[2];
    auto b = input[3];
    auto m = input[4];
    auto S = new int[](N);

    S[0] = x % 10;
    
    foreach (i; 1..N) {
        x = ((x ^ a) + b) % m;
        S[i] = x % 10;
    }
    

    if (S.map!(s => s == 0).all) {
        writeln(0);
        return;
    }

    
    int C = 1;
    int C3 = 0;
    int ans = 0;

    foreach (i; 0..N) {
        int tmp_3 = 0;
        
        while (S[i] > 0 && S[i] % 3 == 0)
            tmp_3 += 1, S[i] /= 3;
        
        int C3C3 = C3 + tmp_3 >= 2 ? 0 : C3 + tmp_3 == 1 ? 3 : 1;

        ans += C % 9 * C3C3 % 9 * S[i] % 9;
        ans %= 9;

        
        int num = N - 1 - i;
        int den = i + 1;

        while (num > 0 && num % 3 == 0)
            C3 += 1, num /= 3;
        while (den % 3 == 0)
            C3 -= 1, den /= 3;

        C = C * num % 9 * inv[den % 9] % 9;
    }

    writeln(ans ? ans : 9);
}


void main() {
    auto T = readln.chomp.to!int;
    while (T--)
        solve;
}

