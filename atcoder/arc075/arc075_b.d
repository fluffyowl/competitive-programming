import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int).array;
    auto N = s[0];
    auto A = s[1].to!long;
    auto B = s[2].to!long;
    auto H = N.iota.map!(_ => readln.chomp.to!long).array;

    long hi = 10L ^^ 9 + 1;
    long lo = 0;

    while (hi - lo > 1) {
        auto mid = (hi + lo) / 2;
        long tmp = 0;
        foreach (i; 0..N) {
            if (H[i] - mid * B > 0)
                tmp += max(0, (H[i] - mid * B - 1) / (A - B) + 1);
        }
        if (tmp <= mid)
            hi = mid;
        else
            lo = mid;
    }

    hi.writeln;
}
