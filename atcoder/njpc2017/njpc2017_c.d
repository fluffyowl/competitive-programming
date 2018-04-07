import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

const long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto L = s[1].to!long;
    auto X = N.iota.map!(_ => readln.chomp.to!long).array;
    Tuple!(long, long)[] Y;

    int first = 0;
    foreach (i; 1..N) {
        if (X[i] - X[i-1] < L) {
            continue;
        } else {
            Y ~= tuple(X[first], X[i-1]);
            first = i;
        }
    }
    if (Y.empty || Y[$-1][1] != X[$-1]) {
        Y ~= tuple(X[first], X[$-1]);
    }

    long pos = 0;
    foreach (y; Y) {
        if (y[1] - y[0] >= L) {
            writeln("NO");
            return;
        } else if (pos < y[1]) {
            pos = max(y[1] + L, pos + L + L);
        } else {
            writeln("NO");
            return;
        }
    }

    writeln("YES");
}
