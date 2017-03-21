import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    auto s = 3.iota.map!(_ => readln.chomp.to!long).array.sort();
    auto t1 = s[0];
    auto t2 = s[1];
    auto t3 = s[2];

    auto a = (t3 - t1) * t1 * t2;
    auto b = (t2 - t1) * t1 * t3;
    auto c = gcd(a, b);
    a /= c;
    b /= c;

    auto d = t1 * t2 * b;
    auto e = t2 - t1;
    auto f = gcd(d, e);
    writeln(d/f, "/", e/f);

}

