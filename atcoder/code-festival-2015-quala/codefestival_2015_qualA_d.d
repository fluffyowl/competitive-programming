import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto X = M.iota.map!(_ => readln.chomp.to!int).array;

    long hi = 10L^^10;
    long lo = -1;
    while (hi - lo > 1) {
        long mid = (hi + lo) / 2;
        long pos = 0;
        foreach (i; 0..M) {
            pos = min(pos, X[i] - 1);
            if (mid < X[i] - pos - 1)
                break;
            long left = X[i] - pos - 1;

            long hihi = 10L^^10;
            long lolo = 0;
            while (hihi - lolo > 1) {
                long midmid = (hihi + lolo) / 2;
                long tmp = midmid <= left ? midmid * 2 + left : midmid + left * 2;
                if (tmp <= mid) lolo = midmid;
                else hihi = midmid;
            }

            pos = X[i] + lolo;
        }
        if (pos >= N) hi = mid;
        else lo = mid;
    }

    hi.writeln;
}
