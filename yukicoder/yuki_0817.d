import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1].to!long;
    auto AB = N.iota.map!(_ => readln.split.map!(to!long).array).array;

    bool check(long x) {
        long tmp = 0;
        foreach (ab; AB) {
            if (ab[1] <= x) {
                tmp += ab[1] - ab[0] + 1;
            } else if (ab[0] <= x) {
                tmp += x - ab[0] + 1;
            }
        }
        return tmp >= K;
    }

    long hi = 10L^^9;
    long lo = 0;

    while (hi - lo > 1) {
        long mid = (hi + lo) / 2;
        (check(mid) ? hi : lo) = mid;
    }

    hi.writeln;
}
