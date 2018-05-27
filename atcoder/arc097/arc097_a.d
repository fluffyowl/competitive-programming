import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.regex;

void main() {
    auto S = readln.chomp;
    auto K = readln.chomp.to!int;
    auto N = S.length.to!int;

    bool[string] cnt;
    foreach (len; 1..min(11, N+1)) {
        foreach (i; 0..N-len+1) {
            cnt[S[i..i+len]] = true;
        }
    }

    auto x = cnt.keys.array;
    x.sort();
    x[K-1].writeln;
}
