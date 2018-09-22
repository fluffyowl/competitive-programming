import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;
immutable long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.split.map!(to!int).array).array;
    auto S = A.map!(a => a.sum).sum % 2;
    Tuple!(int, int, int, int)[] ans;

    foreach (i; 0..H) {
        foreach (j; 0..W-1) {
            if (A[i][j] % 2 == 1) {
                if (S == 1) {
                    S = 0;
                    continue;
                }
                ans ~= tuple(i+1, j+1, i+1, j+2);
                A[i][j+1] += 1;
            }
        }
        if (A[i][W-1] % 2 == 1 && S == 0) {
            ans ~= tuple(i+1, W, i+2, W);
            A[i+1][W-1] += 1;
        }
    }

    ans.length.writeln;
    foreach (a; ans) writeln(a[0], " ", a[1], " ", a[2], " ", a[3]);
}
