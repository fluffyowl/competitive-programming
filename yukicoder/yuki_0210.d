import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    auto N = readln.chomp.to!int;
    auto P = readln.split.map!(x => x.to!real / 1000).array;
    auto Q = readln.split.map!(x => x.to!real / 100).array;

    auto pq = new BinaryHeap!(Array!(Tuple!(real, int)), "a[0] < b[0]");
    foreach (i; 0..N) pq.insert(tuple(P[i] * Q[i], i));

    real ans = 0;
    
    const int TRY = 10^^6;
    foreach (i; 1..TRY+1) {
        auto t = pq.front;
        ans += i * t[0];
        pq.replaceFront(tuple(t[0] * (1 - Q[t[1]]), t[1]));
    }

    writefln("%.9f", ans);
}

