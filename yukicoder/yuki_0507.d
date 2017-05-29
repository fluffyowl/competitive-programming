import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto a0 = readln.chomp.to!int;
    auto A = (N-1).iota.map!(_ => readln.chomp.to!int).array;
    A.sort();

    bool ok(int m) {
        int x = a0 + A[m];
        int cnt = 0;
        auto rbt = new RedBlackTree!(int, "a < b", true)(A);
        rbt.removeKey(A[m]);
        
        foreach (i; 0..N-1) {
            if (i == m) continue;
            if (rbt.equalRange(A[i]).empty) continue;

            rbt.removeKey(A[i]);
            auto ub = rbt.upperBound(x - A[i]);
            if (ub.empty) continue;
            auto y = ub.front;
            rbt.removeKey(y);
            cnt += 1;
        }

        return cnt < M;
    }

    if (!ok(N-2)) {
        writeln(-1);
        return;
    }
    
    int hi = N-2;
    int lo = 0;
    while (hi - lo > 1) {
        int mid = (hi + lo) / 2;
        if (ok(mid)) hi = mid;
        else lo = mid;
    }

    writeln( ok(lo) ? A[lo] : A[hi]);
}

