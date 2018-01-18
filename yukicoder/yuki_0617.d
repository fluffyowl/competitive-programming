import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split;
    auto N = s[0].to!int;
    auto K = s[1].to!int;
    auto A = N.iota.map!(_ => readln.chomp.to!int).array;

    int ans = 0;

    foreach (mask; 0..(1<<N)) {
        int cnt = 0;
        foreach (i; 0..N) {
            if (mask & (1 << i)) {
                cnt += A[i];
            }
        }
        if (cnt <= K) ans = max(ans, cnt);
    }

    ans.writeln;
}

