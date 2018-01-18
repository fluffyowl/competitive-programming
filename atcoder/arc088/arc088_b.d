import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;

    if (S.map!(s => s == S[0]).all) {
        writeln(N);
        return;
    }

    int ans = 1000000;
    foreach (i; 0..N-1) if (S[i] != S[i+1]) ans = min(ans, max(i+1,N-i-1));

    ans.writeln;
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;

    if (S.map!(s => s == S[0]).all) {
        writeln(N);
        return;
    }

    int ans = 1000000;
    foreach (i; 0..N-1) if (S[i] != S[i+1]) ans = min(ans, max(i+1,N-i-1));

    ans.writeln;
}
