import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!long);
    auto N = s[0];
    auto M = s[1];

    if (gcd(N, M) == 1) {
        writeln(M-1);
    } else if (N % M == 0) {
        writeln(0);
    } else {
        writeln(M-gcd(M, N));
    }
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!long);
    auto N = s[0];
    auto M = s[1];

    if (gcd(N, M) == 1) {
        writeln(M-1);
    } else if (N % M == 0) {
        writeln(0);
    } else {
        writeln(M-gcd(M, N));
    }
}
