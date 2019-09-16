import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    long ans = 0;

    foreach (i; 0..N) {
        if (S[i] != 'M') continue;
        foreach (j; 0..i) {
            int k = 2 * i - j;
            if (k < 0 || k >= N) continue;
            if (S[j] == 'U' && S[k] == 'G') ans += 1;
        }
    }

    ans.writeln;
}

