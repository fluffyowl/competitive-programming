import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long INF = 1L << 60;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto X = s[1].to!long;
    auto Y = s[2].to!long;
    auto A = readln.split.map!(to!long).array;

    auto mem = new long[][](N+1, 2);
    foreach (i; 0..N+1) mem[i].fill(-1);

    long dfs(int n, int turn) {
        if (mem[n][turn] >= 0)
            return mem[n][turn];

        long ret;
        if (turn == 0) {
            long yp = n == 0 ? Y : A[n-1];
            ret = abs(yp - A[$-1]);
        } else {
            long xp = n == 0 ? X : A[n-1];
            ret = abs(xp - A[$-1]);
        }

        if (turn == 0) { // 先手
            foreach (i; n+1..N) {
                ret = max(ret, dfs(i, 1));
            }
        } else {
            foreach (i; n+1..N) {
                ret = min(ret, dfs(i, 0));
            }
        }

        mem[n][turn] = ret;
        return ret;
    }

    dfs(0, 0).writeln;
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long INF = 1L << 60;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto X = s[1].to!long;
    auto Y = s[2].to!long;
    auto A = readln.split.map!(to!long).array;

    auto mem = new long[][](N+1, 2);
    foreach (i; 0..N+1) mem[i].fill(-1);

    long dfs(int n, int turn) {
        if (mem[n][turn] >= 0)
            return mem[n][turn];

        long ret;
        if (turn == 0) {
            long yp = n == 0 ? Y : A[n-1];
            ret = abs(yp - A[$-1]);
        } else {
            long xp = n == 0 ? X : A[n-1];
            ret = abs(xp - A[$-1]);
        }

        if (turn == 0) { // 先手
            foreach (i; n+1..N) {
                ret = max(ret, dfs(i, 1));
            }
        } else {
            foreach (i; n+1..N) {
                ret = min(ret, dfs(i, 0));
            }
        }

        mem[n][turn] = ret;
        return ret;
    }

    dfs(0, 0).writeln;
}
