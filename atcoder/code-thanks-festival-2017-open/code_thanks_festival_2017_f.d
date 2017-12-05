import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto A = N.iota.map!(_ => readln.chomp.to!int).array;
    long[int][2] dp;
    dp[0][0] = 1;
    int cur = 0, tar = 1;

    foreach (i; 0..N) {
        dp[tar] = dp[cur].dup;
        foreach (k; dp[cur].keys) {
            (dp[tar][k^A[i]] += dp[cur][k]) %= MOD;
        }
        cur ^= 1;
        tar ^= 1;
    }

    if (K in dp[cur]) {
        writeln(dp[cur][K]);
    } else {
        writeln(0);
    }


} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto A = N.iota.map!(_ => readln.chomp.to!int).array;
    long[int][2] dp;
    dp[0][0] = 1;
    int cur = 0, tar = 1;

    foreach (i; 0..N) {
        dp[tar] = dp[cur].dup;
        foreach (k; dp[cur].keys) {
            (dp[tar][k^A[i]] += dp[cur][k]) %= MOD;
        }
        cur ^= 1;
        tar ^= 1;
    }

    if (K in dp[cur]) {
        writeln(dp[cur][K]);
    } else {
        writeln(0);
    }


}
