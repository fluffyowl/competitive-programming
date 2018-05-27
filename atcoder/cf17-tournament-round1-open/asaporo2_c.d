import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0] * 2;
    auto Q = s[1];
    auto A = readln.split.map!(to!long).array;
    auto B = readln.split.map!(to!long).array;
    
    auto rbt = new RedBlackTree!(long, "a > b", true)();
    long sm = 0;
    int cnt = 0;
    foreach (i; 0..N) {
        if (i == 0 || i == N-1) {
            sm += A[i];
        } else if (A[i] >= B[i]) {
            sm += A[i];
            rbt.insert(B[i] - A[i]);
        } else {
            sm += B[i];
            cnt += 1;
            rbt.insert(A[i] - B[i]);
        }
    }

    while (Q--) {
        s = readln.split.map!(to!int);
        auto p = s[0] - 1;
        auto x = s[1].to!long;
        auto y = s[2].to!long;
        if (p == 0 || p == N - 1) {
            sm = sm - A[p] + x;
            A[p] = x;
            B[p] = y;
        } else {
            sm = sm - max(A[p], B[p]) + max(x, y);
            rbt.removeKey(-abs(A[p] - B[p]));
            rbt.insert(-abs(x - y));
            if (A[p] < B[p]) cnt -= 1;
            if (x < y) cnt += 1;
            A[p] = x;
            B[p] = y;
        }
        writeln(cnt % 2 ? sm + rbt.front : sm);
    }
}
