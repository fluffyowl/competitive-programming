import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

immutable int INF = 1 << 28;

void main() {
    auto N = readln.chomp.to!int;
    auto S = readln.split.map!(to!int).array;

    auto mem = new int[][](N+1, 11);
    foreach (i; 0..N+1) fill(mem[i], -1);

    int dp(int n, int k) {
        if (n == 0 && k == 0) return 1;
        if (n < 0 || k < 0) return INF;
        if (k > S[n]) return INF;
        if (mem[n][k] >= 0) return mem[n][k];
        
        int ret = INF;
        ret = min(ret, dp(n-1, k) + 1);

        foreach (i; 0..k) {
            ret = min(ret, dp(n, i) + dp(n, k-i-1));
        }
        
        return mem[n][k] = ret;
    }

    int[] ans;
    for (int i = 0; i <= S[N]; i++) ans ~= dp(N, i);
    ans.map!(a => a.to!string).join(" ").writeln;
}

