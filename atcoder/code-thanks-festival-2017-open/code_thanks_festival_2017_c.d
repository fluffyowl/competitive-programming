import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto pq = new BinaryHeap!(Array!(Tuple!(long, long)), "a[0] > b[0]");

    foreach (i; 0..N) {
        auto t = readln.split.map!(to!long);
        pq.insert(tuple(t[0], t[1]));
    }

    long ans = 0;
    while (K--) {
        auto top = pq.front;
        pq.removeFront;
        ans += top[0];
        pq.insert(tuple(top[0]+top[1], top[1]));
    }

    ans.writeln;
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto pq = new BinaryHeap!(Array!(Tuple!(long, long)), "a[0] > b[0]");

    foreach (i; 0..N) {
        auto t = readln.split.map!(to!long);
        pq.insert(tuple(t[0], t[1]));
    }

    long ans = 0;
    while (K--) {
        auto top = pq.front;
        pq.removeFront;
        ans += top[0];
        pq.insert(tuple(top[0]+top[1], top[1]));
    }

    ans.writeln;
}
