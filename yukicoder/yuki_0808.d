import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split;
    auto N = s[0].to!int;
    auto L = s[1].to!long;
    auto A = readln.split.map!(to!long).array;
    auto B = readln.split.map!(to!long).array;

    Tuple!(int, int, int, long)[] C;
    for (int i = 0, j = 0; i < N || j < N; ) {
        if (j >= N || (i < N && A[i] < B[j])) {
            if (!C.empty && C.back[2] == 0) {
                C.back[1] = i;
                C.back[3] = A[i];
            } else {
                C ~= tuple(i, i, 0, A[i]);
            }
            ++i;
        } else {
            if (!C.empty && C.back[2] == 1) {
                C.back[1] = j;
                C.back[3] = B[j];
            } else {
                C ~= tuple(j, j, 1, B[j]);
            }
            ++j;
        }
    }

    if (C.back[2] == C.front[2]) {
        auto t = C.back;
        C.popBack;
        C.front[0] = t[0];
    }

    auto rbt = new RedBlackTree!(Tuple!(int[], int, long), "a[2] < b[2]");
    foreach (c; C) {
        if (c[1] >= c[0]) {
            rbt.insert(tuple(iota(c[0], c[1]+1).array, c[2], c[3]));
        } else {
            rbt.insert(tuple(iota(c[0], N).array ~ iota(0, c[1]+1).array, c[2], c[3]));
        }
    }

    long ans = 0;
    long pos = 0;
    int turn = 0;
    auto hoge = new int[](0);

    foreach (_; 0..2*N) {
        auto ub = rbt.upperBound(tuple(hoge, 0, pos));

        if (ub.empty) {
            ub = rbt.upperBound(tuple(hoge, 0, 0L));
        }

        if (turn != ub.front[1]) {
            ub.popFront;
            if (ub.empty) ub = rbt.upperBound(tuple(hoge, 0, 0L));
        }

        auto tar = ub.front;

        long next = tar[2];
        if (pos < next) ans += next - pos;
        else ans += L - pos + next;

        debug {
            writeln([pos, next, ans]);
        }

        pos = next;
        if (_ == 2 * N - 1) break;


        rbt.removeKey(tar);
        if (tar[0].length == 1) {
            auto x = rbt.upperBound(tar);
            auto y = rbt.lowerBound(tar);
            auto n = x.empty ? rbt.front : x.front;
            auto p = y.empty ? rbt.back : y.back;
            if (n[2] != p[2]) {
                rbt.removeKey(n);
                rbt.removeKey(p);
                rbt.insert(tuple(p[0] ~ n[0], p[1], n[2]));
            }
        } else {
            tar[0].popBack;
            if (tar[1] == 0) tar[2] = A[tar[0].back];
            else tar[2] = B[tar[0].back];
            rbt.insert(tar);
        }

        debug {
            _.writeln;
            rbt.writeln;
        }

        turn ^= 1;
    }

    ans.writeln;
}

