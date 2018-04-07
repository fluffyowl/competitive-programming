import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;


void main() {
    auto N = readln.chomp.to!int;
    auto AB = N.iota.map!(_ => readln.split.map!(to!int).array).array;
    auto M = readln.chomp.to!int;
    auto XY = M.iota.map!(_ => readln.split.map!(to!int).array).array;
    auto cnt = new int[](M);

    foreach (i; 0..N)
        foreach (j; 0..M)
            if (XY[j][0] <= AB[i][0] && XY[j][1] >= AB[i][1])
                cnt[j] += 1;

    auto m = cnt.reduce!max;
    if (m == 0) {
        0.writeln;
    } else {
        foreach (i; 0..M) if (cnt[i] == m) (i+1).writeln;
    }
}

