import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!long);
    auto A = s[0];
    auto B = s[1];
    auto C = s[2];
    auto X = s[3];
    auto Y = s[4];
    long ans = 1L << 59;

    for (long ab = 0; ab <= 2 * max(X, Y); ab += 2) {
        long a = max(0, X - ab/2);
        long b = max(0, Y - ab/2);
        ans = min(ans, a * A + b * B + ab * C);
    }

    ans.writeln;
}
