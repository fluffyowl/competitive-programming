import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto X = new long[](N);
    auto W = new long[](N);
    foreach (i; 0..N) {
        auto s = readln.split.map!(to!long);
        X[i] = s[0];
        W[i] = s[1];
    }

    real calc(real x) {
        real ans = 0;
        foreach (i; 0..N) {
            ans = max(ans, abs(x - X[i]) * W[i]);
        }
        return ans;
    }

    real lo = X.front;
    real hi = X.back;

    foreach (_; 0..100) {
        real mid1 = (hi*2 + lo) / 3;
        real mid2 = (hi + lo*2) / 3;
        if (calc(mid1) >= calc(mid2)) {
            hi = mid1;
        } else {
            lo = mid2;
        }
    }

    writefln("%.09f", hi);
}
