import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto A = readln.split.map!(to!long).array;
    auto B = new long[](N+1);
    foreach (i; 0..N) B[i+1] = B[i] + A[i];

    long[long] cnt;
    foreach (i; 1..N+1) cnt[B[i] % M] += 1;
    long ans = 0;

    foreach (i; 0..N) {
        if ((B[i] % M) in cnt)
            ans += cnt[B[i] % M];
        cnt[B[i+1]%M] -= 1;
    }

    ans.writeln;
}
