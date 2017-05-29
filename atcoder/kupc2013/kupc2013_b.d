import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto X = s[1];
    auto M = s[2];
    auto Q = M.iota.map!(_ => readln.split.map!(to!int).array).array;

    auto A = new int[](N);
    auto B = new int[](N+1);
    int[] ans_arr;
    int ans_v = -1;

    bool ok() {
        fill(B, 0);
        foreach (i; 0..N) B[i+1] = B[i] + A[i];
        return Q.map!(q => B[q[1]] - B[q[0] - 1] == q[2]).all;
    }

    void dfs(int n) {
        if (n == N) {
            if(ok && A.sum > ans_v) {
                ans_v = A.sum;
                ans_arr = A.dup;
            }
            return;
        }

        foreach (i; 0..X+1) {
            A[n] = i;
            dfs(n+1);
        }
    }

    dfs(0);
    if (ans_v >= 0) ans_arr.map!(a => a.to!string).join(" ").writeln;
    else writeln(-1);

}
