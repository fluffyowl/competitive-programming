import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    long ans = 0;
    foreach (a; A) {
        while (a % 2 == 0) ans += 1, a /= 2;
    }
    ans.writeln;
}
