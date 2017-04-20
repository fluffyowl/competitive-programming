import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto txa = s[0];
    auto tya = s[1];
    auto txb = s[2];
    auto tyb = s[3];
    auto T = s[4];
    auto V = s[5];
    auto N = readln.chomp.to!int;
    auto D = T * V;

    foreach (i; 0..N) {
        s = readln.split.map!(to!int);
        auto x = s[0];
        auto y = s[1];
        auto d1 = (txa-x)^^2 + (tya - y)^^2;
        auto d2 = (txb-x)^^2 + (tyb - y)^^2;
        auto d = sqrt(d1.to!real) + sqrt(d2.to!real);
        if (d <= D) {
            writeln("YES");
            return;
        }
    }

    writeln("NO");
}
