import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


immutable long MOD = 10^^9+7;

void main() {
    auto s = readln.split.map!(to!long);
    auto N = s[0];
    auto M = s[1];
    auto X = readln.split.map!(to!long).array;
    auto Y = readln.split.map!(to!long).array;
    auto DX = new long[](N-1);
    auto DY = new long[](M-1);
    foreach (i; 0..N-1) DX[i] = (X[i+1] - X[i]) % MOD;
    foreach (i; 0..M-1) DY[i] = (Y[i+1] - Y[i]) % MOD;

    long width = 0;
    long left = 1;
    long right = N - 1;
    foreach (i; 0..N-1) {
        width += left * right % MOD * DX[i] % MOD;
        width %= MOD;
        left += 1;
        right -= 1;
    }

    long ans = 0;
    long up = 1;
    long down = M - 1;
    foreach (i; 0..M-1) {
        ans += up * down % MOD * width % MOD * DY[i] % MOD;
        ans %= MOD;
        up += 1;
        down -= 1;
    }

    ans.writeln;

}
