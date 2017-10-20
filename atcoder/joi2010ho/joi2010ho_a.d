import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto D = (N-1).iota.map!(_ => readln.chomp.to!long).array;
    auto A = M.iota.map!(_ => readln.chomp.to!int).array;
    auto S = new long[](N);
    S[0] = 0;
    foreach (i; 0..N-1)
        S[i + 1] = S[i] + D[i];

    long MOD = 10^^5;
    long ans = 0;
    int pos = 0;

    foreach (a; A) {
        int npos = pos + a;
        ans = (ans + abs(S[pos] - S[npos])) % MOD;
        pos = npos;
    }

    ans.writeln;
}
