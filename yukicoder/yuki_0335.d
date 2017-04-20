import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto E = new int[][](M);
    foreach (i; 0..M) E[i] = readln.split.map!(to!int).array;

    
    long ans_v = 0;
    int  ans_i = 0;
    
    foreach (i; 0..M) {
        long e = 0;
        auto rbt_l = new RedBlackTree!(int)();

        foreach (j; 0..N) {
            auto rbt_m = new RedBlackTree!(int)();
            auto rbt_r = new RedBlackTree!(int)();
            foreach (k; j+2..N) rbt_r.insert(E[i][k]);
            
            foreach (k; j+1..N) {
                long et = 0;
                if (E[i][j] < E[i][k]) {
                    auto l  = rbt_l.upperBound(E[i][j]);
                    if (!l.empty) et = max(et, max(l.back, E[i][k]));
                    auto ml = rbt_m.lowerBound(E[i][j]);
                    if (!ml.empty) et = max(et, E[i][k]);
                    auto mu = rbt_m.upperBound(E[i][k]);
                    if (!mu.empty) et = max(et, mu.back);
                    auto r  = rbt_r.lowerBound(E[i][k]);
                    if (!r.empty) et = max(et, E[i][k]);
                }
                else {
                    auto l  = rbt_l.lowerBound(E[i][j]);
                    if (!l.empty) et = max(et, E[i][j]);
                    auto mu = rbt_m.upperBound(E[i][j]);
                    if (!mu.empty) et = max(et, mu.back);
                    auto ml = rbt_m.lowerBound(E[i][k]);
                    if (!ml.empty) et = max(et, E[i][j]);
                    auto r  = rbt_r.upperBound(E[i][k]);
                    if (!r.empty) et = max(et, max(r.back, E[i][j]));
                }

                if (k+1 < N) rbt_r.removeKey(E[i][k+1]);
                rbt_m.insert(E[i][k]);
                e += et;
            }

            rbt_l.insert(E[i][j]);
            
        }


        if (e > ans_v) {
            ans_v = e;
            ans_i = i;
        }
    }

    //ans_v.writeln;
    ans_i.writeln;
}

