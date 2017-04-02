import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

alias Tuple!(int, "x", int, "y", int, "z") Box;

void main() {
    auto N = readln.chomp.to!int;
    auto B = new Box[](N);
    foreach (i; 0..N) {
        auto s = readln.split.map!(to!int).array;
        s.sort!"a > b"();
        B[i] = Box(s[0], s[1], s[2]);
    }
    B.sort!"a.x == b.x ? a.y > b.y : a.x > b.x"();

    auto dp = new int[](N);
    fill(dp, 1);

    foreach (i; 1..N) {
        foreach (j; 0..i) {
            if (B[i].x < B[j].x && B[i].y < B[j].y && B[i].z < B[j].z) {
                dp[i] = max(dp[i], dp[j]+1);
            }
        }
    }

    dp.reduce!max.writeln;
}

