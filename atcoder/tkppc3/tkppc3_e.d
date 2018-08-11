import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    real ans = 0;
    real p = 1;
    //real s = 1.0L * N * (N+1) / 2;
    real s = 1.0L * (N+1) / 2;

    foreach (i; 1..N+1) {
        ans += p * s ;
        p *= 1.0L * (N - i) / N;
    }

    writefln("%.9f", ans);
}
