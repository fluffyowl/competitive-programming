import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    auto Q = readln.chomp.to!int;
    auto B = readln.split.map!(to!long).array;

    auto pq = new BinaryHeap!(Array!long, "a < b");
    foreach (a; A) pq.insert(a);
    long ans = A.sum;

    foreach (b; B) {
        while (pq.front >= b) {
            long v = pq.front;
            pq.removeFront;
            ans -= v;
            ans += v % b;
            pq.insert(v % b);
        }
        ans.writeln;
    }
}

