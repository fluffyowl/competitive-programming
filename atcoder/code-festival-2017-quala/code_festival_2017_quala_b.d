import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto K = s[2];

    foreach (i; 0..H+1) {
        foreach (j; 0..W+1) {
            long tmp = i * W + j * H - (i * j) * 2;
            if (tmp == K) {
                writeln("Yes");
                return;
            }
        }
    }

    writeln("No");
}
