import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto Q = s[1];

    if (N == 1) {
        while (Q--) {
            s = readln.split.map!(to!int);
            auto v = s[0];
            auto w = s[1];
            writeln(min(v, w));
        }
        return;
    }

    while (Q--) {
        s = readln.split.map!(to!int);
        auto v = s[0]-1;
        auto w = s[1]-1;
        while (v != w) {
            if (v > w)
                swap(v, w);
            int q = w % N;
            if (q == 0) q = N;
            w = (w-q) / N;
        }
        writeln(v+1);
    }

} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto Q = s[1];

    if (N == 1) {
        while (Q--) {
            s = readln.split.map!(to!int);
            auto v = s[0];
            auto w = s[1];
            writeln(min(v, w));
        }
        return;
    }

    while (Q--) {
        s = readln.split.map!(to!int);
        auto v = s[0]-1;
        auto w = s[1]-1;
        while (v != w) {
            if (v > w)
                swap(v, w);
            int q = w % N;
            if (q == 0) q = N;
            w = (w-q) / N;
        }
        writeln(v+1);
    }

}
