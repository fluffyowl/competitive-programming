import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto P = s[1];
    auto WB = N.iota.map!(_ => readln.split.map!(to!long).array).array;
    long score(long w, long b) {
        return w * (100 - P) - b * P;
    }
    WB.sort!((a, b) => score(a[0], -a[1]) > score(b[0], -b[1]));

    long w = 0;
    long b = WB.map!(wb => wb[1]).sum;
    int ans = N;

    foreach (i; 0..N) {
        if (score(w, b) >= 0 && ans == N)
            ans = i;
        w += WB[i][0];
        b -= WB[i][1];
    }

    ans.writeln;
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto P = s[1];
    auto WB = N.iota.map!(_ => readln.split.map!(to!long).array).array;
    long score(long w, long b) {
        return w * (100 - P) - b * P;
    }
    WB.sort!((a, b) => score(a[0], -a[1]) > score(b[0], -b[1]));

    long w = 0;
    long b = WB.map!(wb => wb[1]).sum;
    int ans = N;

    foreach (i; 0..N) {
        if (score(w, b) >= 0 && ans == N)
            ans = i;
        w += WB[i][0];
        b -= WB[i][1];
    }

    ans.writeln;
}
