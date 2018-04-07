import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    int px = 0, py = 0, pt = 0;

    foreach (_; 0..N) {
        auto s = readln.split.map!(to!int);
        auto t = s[0];
        auto x = s[1];
        auto y = s[2];
        auto dt = t - pt;
        auto dx = abs(x - px);
        auto dy = abs(y - py);
        if (dt < dx + dy) {
            writeln("No");
            return;
        }
        if ((dt - dx - dy) % 2 != 0) {
            writeln("No");
            return;
        }
        pt = t;
        px = x;
        py = y;
    }

    writeln("Yes");
}
