import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    alias Circle = Tuple!(long, "x", long, "y", real, "r");

    auto s = readln.split.map!(to!long);
    auto N = s[0].to!int;
    auto M = s[1].to!int;
    auto A = new Circle[](N);
    auto B = new Circle[](M);
    foreach (i; 0..N) {
        s = readln.split.map!(to!long);
        A[i] = Circle(s[0], s[1], s[2].to!real);
    }
    foreach (i; 0..M) {
        s = readln.split.map!(to!long);
        B[i] = Circle(s[0], s[1], 0.0L);
    }

    real dist(Circle a, Circle b) {
        return sqrt(1.0L * (a.x-b.x) * (a.x-b.x) + (a.y-b.y) * (a.y-b.y));
    }

    real rr(Circle a, Circle b) {
        return a.r + b.r;
    }

    bool check(Circle a, Circle b) {
        return dist(a, b) >= rr(a, b);
    }

    real hi = A.length ? A.map!(a => a[2]).reduce!min : 10000;
    real lo = 0;

    foreach (_; 0..1000) {
        real mid = (hi + lo) / 2;
        bool ok = true;
        foreach (i; 0..M) {
            B[i].r = mid;
        }
        foreach (i; 0..M) {
            foreach (j; 0..N) if (!check(B[i], A[j])) ok = false;
            foreach (j; 0..M) if (i != j && !check(B[i], B[j])) ok = false;
        }
        if (ok) lo = mid;
        else hi = mid;
    }

    writefln("%.09f", hi);
}
