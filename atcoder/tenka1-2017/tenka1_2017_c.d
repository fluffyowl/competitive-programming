import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    const long MAX = 3501;
    auto N = readln.chomp.to!long;

    foreach (b; 1..MAX) {
        foreach (c; 1..MAX) {
            long bunbo = 4 * b * c - b * N - c * N;
            long bunsi = b * c * N;
            if (bunbo <= 0 || bunsi % bunbo != 0)
                continue;
            long a = bunsi / bunbo;
            writeln(a, " ", b, " ", c);
            return;
        }
    }
}
