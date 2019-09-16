import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto N = readln.chomp.to!int;
    auto KLD = N.iota.map!(_ => readln.split.map!(to!long).array).array;

    bool check(long x) {
        long cnt = 0;
        foreach (kld; KLD) {
            auto k = kld[0], l = kld[1], d = kld[2];
            if (x < l) continue;
            cnt ^= min(k, (x - l) / (1L << d) + 1) & 1;
        }
        return cnt & 1;
    }

    long hi = 10L ^^ 18;
    long lo = -1;

    while (hi - lo > 1) {
        long mid = (hi + lo) / 2;
        (check(mid) ? hi : lo) = mid;
    }

    hi.writeln;
}
