import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    immutable long MOD = 10^^9 + 7;
    
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];

    
    auto dp = new long[](N);
    dp[0] = 0;
    dp[1] = 1;
    
    long cs = 1;
    
    foreach (i; 2..K) {
        (dp[i] += dp[i-1] * 2 % MOD) %= MOD;
        (cs += dp[i]) %= MOD;
    }

    foreach (i; K..N-1) {
        dp[i] = cs;
        cs = cs - dp[i-K] + dp[i];
        cs = (cs % MOD + MOD) % MOD;
    }

    
    long ans = 0;

    foreach (i; N-K..N-1) {
        (ans += dp[i]) %= MOD;
    }

    ans.writeln;
}
