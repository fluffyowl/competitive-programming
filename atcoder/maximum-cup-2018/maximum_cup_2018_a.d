import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    int ans = 0;

    foreach (_; 0..N) {
        auto s = readln.split.map!(to!int);
        auto t = s[0];
        auto d = s[1];
        auto m = s[2];
        if (d - t >= 10) ans += m;
    }

    ans.writeln;
}
