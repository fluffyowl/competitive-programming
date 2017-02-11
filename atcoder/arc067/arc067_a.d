import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


immutable long MOD = 10^^9+7;


void main() {
    auto N = readln.chomp.to!int;
    auto cnt = new long[](10^^3+1);
    fill(cnt, 0);
    foreach (i; 2..N+1) {
        int j = 2;
        while (j * j <= i) {
            while (i % j == 0) {
                i /= j;
                cnt[j]++;
            }
            j++;
        }
        if (i > 1)
            cnt[i]++;
    }

    long ans = 1;
    foreach (i; 2..N+1) {
        ans = (ans * (cnt[i]+1)) % MOD;
    }
    ans.writeln;
}
