import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto X = s[0];
    auto Y = s[1];
    auto Z = s[2];
    auto N = X + Y + Z;
    auto A = new Tuple!(long, long, long)[](N);
    foreach (i; 0..N) {
        s = readln.split.map!(to!int);
        A[i] = tuple(s[0], s[1], s[2]);
    }
    A.sort!"a[1] - a[0] < b[1] - b[0]"();

    auto pq = new BinaryHeap!(Array!long, "a < b")();
    auto ans1 = new long[](N);
    long tmp = 0;

    foreach (i; 0..N) {
        ans1[i] = tmp;
        tmp += A[i][0];
        pq.insert(A[i][2] - A[i][0]);
        if (i + 1 > X) {
            auto t = pq.front;
            pq.popFront;
            tmp += t;
        }
    }

    
    pq.clear;
    auto ans2 = new long[](N);
    tmp = 0;
    
    foreach (i; 0..N) {
        ans2[i] = tmp;
        tmp += A[N-i-1][1];
        pq.insert(A[N-i-1][2] - A[N-i-1][1]);
        if (i + 1 > Y) {
            auto t = pq.front;
            pq.popFront;
            tmp += t;
        }
    }


    long ans = 0;
    foreach (i; 0..N) {
        if (i >= X && N - i >= Y) ans = max(ans, ans1[i] + ans2[N-i]);
    }

    ans.writeln;
}
