import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable long INF = 1L << 59;
    immutable int N = 100;
    immutable long MAX = 100000;

    auto A = N.iota.map!(_ => readln.split.map!(to!long).array).array;
    auto B = new long[][](N, N);
    int Q = 1000;
    Tuple!(int, int, long)[] ans;


    long eval(int r, int c, long h) {
        long old = 0;
        long cur = 0;
        foreach (i; -h..h+1) {
            foreach (j; -h..h+1) {
                int nr = r + i.to!int;
                int nc = c + j.to!int;
                if (nr < 0 || nr >= N || nc < 0 || nc >= N) continue;
                old += abs(A[nr][nc] - B[nr][nc]);
                cur += abs(A[nr][nc] - (B[nr][nc] + max(h - i - j, 0L)));
            }
        }
        return cur - old;
    }

    void add(int r, int c, long h) {
        foreach (i; -h..h+1) {
            foreach (j; -h..h+1) {
                int nr = r + i.to!int;
                int nc = c + j.to!int;
                if (nr < 0 || nr >= N || nc < 0 || nc >= N) continue;
                B[nr][nc] += max(h - i - j, 0L);
            }
        }
    }


    foreach (q; 0..Q) {
        long best_score = 0;
        int best_r = -1;
        int best_c = -1;
        long best_h = -1;
        foreach (_; 0..10) {
            int r = uniform(0, N);
            int c = uniform(0, N);
            long h = uniform(1, N+1);
            long score = eval(r, c, h);
            if (score < best_score) {
                best_score = score;
                best_r = r;
                best_c = c;
                best_h = h;
            }
        }
        if (best_score < 0) {
            add(best_r, best_c, best_h);
            ans ~= tuple(best_c, best_r, best_h);
        }
    }

    ans.length.writeln;
    ans.each!(a => writeln(a[0], " ", a[1], " ", a[2]));
    //B.each!(b => b.map!(to!string).join(" ").writeln);
}
