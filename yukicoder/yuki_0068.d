import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    auto N = readln.chomp.to!int;
    auto L = readln.split.map!(to!long).array;
    auto Q = readln.chomp.to!int;
    auto K = readln.split.map!(to!int).array;

    auto M = new int[](N);
    
    auto pq = new BinaryHeap!(Array!(Tuple!(real, int)), "a[0] < b[0]");
    foreach (i; 0..N) pq.insert(tuple(L[i].to!real, i));

    auto ans = new real[](5*10^^5+1);
    ans[0] = 1L << 60;
    
    foreach (i; 1..5*10^^5+1) {
        auto t = pq.front;
        pq.popFront;
        ans[i] = min(ans[i-1], t[0]);
        M[t[1]] += 1;
        pq.insert(tuple(1.0L * L[t[1]] / (M[t[1]] + 1), t[1]));
    }

    foreach (i; 0..Q) {
        writefln("%.10f", ans[K[i]]);
    }
}

