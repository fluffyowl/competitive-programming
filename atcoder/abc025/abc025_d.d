import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;

immutable long MOD = 10^^9 + 7;
int[][] B;
int[26] default_n;
int default_b;
long[int][26] mem;

bool check(int i, int b) {
    if (i/5 != 0 && i/5 != 4) {
        auto prev = 1 << (i - 5);
        auto next = 1 << (i + 5);
        if (!(b & prev) && (b & next)) return false;
        if ((b & prev) && !(b & next)) return false;
    }
    if (i%5 != 0 && i%5 != 4) {
        auto prev = 1 << (i - 1);
        auto next = 1 << (i + 1);
        if (!(b & prev) && (b & next)) return false;
        if ((b & prev) && !(b & next)) return false;
    }
    return true;
}

long dp(int n, int b) {
    if (n > 25) return 1;
    if (b in mem[n]) return mem[n][b];

    if (default_n[n] >= 0) {
        auto i = default_n[n];
        if (!check(i, b)) {
            mem[n][b] = 0;
            return 0;
        }
        mem[n][b] = dp(n+1, b | (1 << i));
        return mem[n][b];
    }

    mem[n][b] = 0;
    foreach (i; 0..25) {
        if ((1 << i) & b) continue;
        if ((1 << i) & default_b) continue;
        if (!check(i, b)) continue;

        mem[n][b] = (mem[n][b] + dp(n+1, b | (1 << i))) % MOD;
    }

    return mem[n][b];
}

void main() {
    B = 5.iota.map!(_ => readln.split.map!(to!int).array).array;

    foreach (i; 0..26) default_n[i] = -1;
    foreach (i; 0..25) {
        if (B[i/5][i%5] != 0) {
            default_b |= (1 << i);
            default_n[B[i/5][i%5]] = i;
        }
    }

    dp(1, 0).writeln;
}
