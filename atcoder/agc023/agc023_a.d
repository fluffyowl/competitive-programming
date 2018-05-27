import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    auto B = new long[](N+1);
    foreach (i; 0..N) B[i+1] = B[i] + A[i];
    long[long] cnt;
    long ans = 0;

    foreach_reverse(i; 0..N) {
        long x = B[i];
        cnt[B[i+1]] += 1;
        if (x in cnt) ans += cnt[x];
    }

    ans.writeln;
}
