import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    auto A = (N+1).iota.map!(_ => readln.chomp.to!long).array;
    auto B = (N+1).iota.map!(_ => readln.chomp.to!long).array;

    auto b = 0;
    foreach (i; 0..N+1) b = (b + B[i]) % MOD;
    long ans = 0;

    foreach (i; 0..N+1) {
        ans += A[i] * b % MOD;
        ans %= MOD;
        b -= B[N-i];
        b %= MOD;
    }

    ans = (ans + MOD) % MOD;
    ans.writeln;
}

