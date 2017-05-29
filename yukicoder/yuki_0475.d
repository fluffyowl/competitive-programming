import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


int point(int star, int rank) {
    return 50 * star + 500 * star / (8 + 2 * rank);
}

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto S = s[1];
    auto W = s[2];
    auto A = readln.split.map!(to!int).array;
    auto WP = A[W] + 100 * S;
    A = A[0..W] ~ A[W+1..N];
    N -= 1;
    auto numerator = new int[](N);

    foreach (i; 0..N) {
        int hi = N + 1;
        int lo = 0;
        while (hi - lo > 1) {
            auto mid = (hi + lo) / 2;
            //writeln(i, " ", hi, " ", lo, " " , A[i] + point(S, mid));
            if (A[i] + point(S, mid) > WP) lo = mid;
            else hi = mid;
        }
        numerator[i] = N + 1 - hi;
    }

    numerator.sort();
    foreach (i; 0..N) {
        numerator[i] -= i;
        if (numerator[i] <= 0) {
            writeln(0.0);
            return;
        } 
    }

    real ans = 1.0L;
    foreach (i; 0..N) ans = ans * numerator[i] / (N - i);
    writefln("%.9f", ans);
}

