import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.datetime;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto H = s[1].to!long;
    auto A = new long[](N);
    auto B = new long[](N);
    foreach (i; 0..N) {
        s = readln.split.map!(to!int);
        A[i] = s[0].to!long;
        B[i] = s[1].to!long;
    }

    auto pq = new BinaryHeap!(Array!(Tuple!(int, long)), "a[1] < b[1]");
    foreach (i; 0..N) pq.insert(tuple(0, A[i]));
    foreach (i; 0..N) pq.insert(tuple(1, B[i]));

    int cnt = 0;
    while (!pq.empty) {
        auto t = pq.front;
        pq.removeFront;
        if (t[0] == 1) {
            H -= t[1];
            cnt += 1;
            if (H <= 0) {
                cnt.writeln;
                return;
            }
        } else {
            cnt += (H - 1) / t[1] + 1;
            cnt.writeln;
            return;
        }
    }
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.datetime;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto H = s[1].to!long;
    auto A = new long[](N);
    auto B = new long[](N);
    foreach (i; 0..N) {
        s = readln.split.map!(to!int);
        A[i] = s[0].to!long;
        B[i] = s[1].to!long;
    }

    auto pq = new BinaryHeap!(Array!(Tuple!(int, long)), "a[1] < b[1]");
    foreach (i; 0..N) pq.insert(tuple(0, A[i]));
    foreach (i; 0..N) pq.insert(tuple(1, B[i]));

    int cnt = 0;
    while (!pq.empty) {
        auto t = pq.front;
        pq.removeFront;
        if (t[0] == 1) {
            H -= t[1];
            cnt += 1;
            if (H <= 0) {
                cnt.writeln;
                return;
            }
        } else {
            cnt += (H - 1) / t[1] + 1;
            cnt.writeln;
            return;
        }
    }
}
