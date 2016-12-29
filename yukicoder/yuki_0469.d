import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


long powmod(long a, long x, long m) {
    long ret = 1;
    while (x >= 1) {
        if (x % 2 == 1)
            ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

void main() {
    immutable long[3] MOD = [1000000009, 2000000357, 3000000821];
    immutable long BASE = uniform(0, MOD.reduce!(min));
    auto powsum = new long[][](3, 10^^6+1);
    pragma(inline, true) {
        powsum[0][0] = powsum[1][0] = powsum[2][0] = 1;
        foreach (j; 0..3)
            foreach (i; 0..10^^6)
                powsum[j][i+1] = (powsum[j][i] + powmod(BASE, i+1, MOD[j])) % MOD[j];
    }

    auto s = readln.split.map!(to!int);
    int N = s[0];
    int Q = s[1];
    long L, R, K;

    int[long][] hash_table = new int[long][](3);
    hash_table[0][0] = hash_table[1][0] = hash_table[2][0] = 0;
    long[3] prev = [0, 0, 0];

    foreach (i; 1..Q+1) {
        auto q = readln.split;
        if (q[0] == "!") {
            L = q[1].to!long;
            R = q[2].to!long;
            K = q[3].to!long;
            foreach (j; 0..3) {
                long plus = ((abs(K) * powmod(BASE, L, MOD[j])) % MOD[j] *
                             powsum[j][R-L-1]) % MOD[j];
                if (K >= 0)
                    prev[j] = (prev[j] + plus) % MOD[j];
                else if (plus > prev[j])
                    prev[j] = (prev[j] - plus) % MOD[j] + MOD[j];
                else
                    prev[j] = (prev[j] - plus) % MOD[j];
                if (!(prev[j] in hash_table[j]))
                    hash_table[j][prev[j]] = i;
            }
        }
        else {
            foreach (j; 0..3) {
                if (hash_table[j][prev[j]] == hash_table[(j+1)%3][prev[(j+1)%3]]) {
                    hash_table[j][prev[j]].writeln;
                    break;
                }
            }
        }
    }
}

