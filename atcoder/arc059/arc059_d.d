import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


immutable long MOD = 10^^9 + 7;

long powmod(long a, long x, long m) {
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

void main() {
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    auto M = S.length.to!int;

    auto mem = new long[][](N + 1, N + 1);
    foreach (i; 0..N+1) fill(mem[i], -1);
   
    // dp(i, j) : i回キーを叩いてj文字入力されている場合の数
    long dp(int i, int j) {
        if (i == 0 && j == 0) return 1;
        if (i <= 0 || j < 0) return 0;
        if (j > i) return 0;
        if (mem[i][j] >= 0) return mem[i][j];

        long ret = 0;
        if (j == 0) {
            ret += dp(i - 1, j);
            ret %= MOD;
        }
        ret += dp(i - 1, j + 1); // Back Space
        ret %= MOD;
        ret += dp(i - 1, j - 1) * 2; // 0 or 1
        ret %= MOD;
        return mem[i][j] = ret;
    }


    auto ans = dp(N, M);
    ans = ans * powmod(powmod(2, MOD-2, MOD), M, MOD) % MOD;
    ans.writeln;
}
