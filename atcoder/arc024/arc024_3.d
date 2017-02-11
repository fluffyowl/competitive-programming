import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;

void main() {
    immutable long[] MOD = [1000000009, 2000000357];
    immutable long BASE = uniform(0, MOD[0]-1);
    auto powmod = new long[][](2, 26);
    powmod[0][0] = powmod[1][0] = 1;
    foreach (i; 1..26) {
        powmod[0][i] = (powmod[0][i-1] * BASE) % MOD[0];
        powmod[1][i] = (powmod[1][i-1] * BASE) % MOD[1];
        if (powmod[0][i] < 0) powmod[0][i] += MOD[0];
        if (powmod[1][i] < 0) powmod[1][i] += MOD[1];
    }

    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto S = readln.chomp;

    int[Tuple!(long, long)] table;
    Tuple!(long, long) hash = tuple(0, 0);
    foreach (i; 0..K) {
        hash[0] = (hash[0] + powmod[0][S[i]-'a']) % MOD[0];
        hash[1] = (hash[1] + powmod[1][S[i]-'a']) % MOD[1];
    }
    if (hash[0] < 0) hash[0] += MOD[0];
    if (hash[1] < 0) hash[1] += MOD[1];
    table[hash] = 0;

    foreach (i; 1..N-K+1) {
        hash[0] = (hash[0] - powmod[0][S[i-1]-'a'] + powmod[0][S[i+K-1]-'a']) % MOD[0];
        hash[1] = (hash[1] - powmod[1][S[i-1]-'a'] + powmod[1][S[i+K-1]-'a']) % MOD[1];
        if (hash[0] < 0) hash[0] += MOD[0];
        if (hash[1] < 0) hash[1] += MOD[1];
        if (hash in table) {
            if (i - table[hash] + 1 > K) {
                writeln("YES");
                return;
            }
        }
        else {
            table[hash] = i;
        }
    }

    writeln("NO");
}
