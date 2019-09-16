import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto s = readln.split.map!(to!int);
    auto n = s[0];
    auto k = s[1] - 1;
    auto X = readln.split.map!(to!long).array;
    auto A = readln.split.map!(to!long).array;

    DList!(Tuple!(long, long)) qmin;
    DList!(Tuple!(long, long)) qmax;
    foreach (i; 0..k) qmin.insertBack(tuple(X[i], A[i]));
    foreach (i; k+1..n) qmax.insertBack(tuple(X[i], A[i]));

    int ans = 0;
    DList!(Tuple!(long, long)) que;
    que.insertBack(tuple(X[k], A[k]));

    long mx = -(10L^^18);
    long mn = 10L^^18;

    while (!que.empty) {
        ans += 1;
        auto t = que.front;
        que.removeFront;
        auto x = t[0];
        auto a = t[1];
        mx = max(mx, x + a);
        mn = min(mn, x - a);
        while (!qmin.empty && qmin.back[0] >= mn) {
            que.insertBack(qmin.back);
            qmin.removeBack;
        }
        while (!qmax.empty && qmax.front[0] <= mx) {
            que.insertBack(qmax.front);
            qmax.removeFront;
        }
    }

    ans.writeln;
}

