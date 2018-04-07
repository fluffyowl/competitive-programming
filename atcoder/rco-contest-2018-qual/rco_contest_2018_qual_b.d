import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.datetime;


void main() {
    auto stattime = Clock.currTime();

    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto D = s[2];
    auto K = s[3];

    auto A = new int[][](H, W);
    foreach (i; 0..H) A[i].fill(-1);

    auto R = new int[](D);
    auto C = new int[](D);

    foreach (i; 0..D) {
        s = readln.split.map!(to!int);
        R[i] = s[0];
        C[i] = s[1];
        A[s[0]][s[1]] = i;
    }


    int eval_swap(int i, int nr, int nc) {
        int cur = 0;
        int next = 0;
        if (i > 0)   cur += abs(R[i] - R[i-1]) + abs(C[i] - C[i-1]);
        if (i < D-1) cur += abs(R[i] - R[i+1]) + abs(C[i] - C[i+1]);
        if (i > 0)   next += abs(nr - R[i-1]) + abs(nc - C[i-1]);
        if (i < D-1) next += abs(nr - R[i+1]) + abs(nc - C[i+1]);
        return next - cur;
    }


    int best_score = 0;
    int[][] commands;

    while ((Clock.currTime - stattime).total!"msecs" < dur!"msecs"(3800).total!"msecs") {
        const int INF = 1 << 29;
        int best_i, best_nr, best_nc, best_j;
        int best_diff = INF;

        foreach (_; 0..1000) {
            int i = uniform(0, D);
            int nr = uniform(0, H);
            int nc = uniform(0, W);
            if (nr == R[i] && nc == C[i]) continue;
            int j = A[nr][nc];
            int diff;

            if (j == -1) {
                diff = eval_swap(i, nr, nc);
            } else {
                diff = eval_swap(i, nr, nc) + eval_swap(j, R[i], C[i]);
            }

            if (diff < best_diff) {
                best_diff = diff;
                best_i = i;
                best_j = j;
                best_nr = nr;
                best_nc = nc;
            }
        }

        int i = best_i;
        int j = best_j;
        int nr = best_nr;
        int nc = best_nc;
        int diff = best_diff;

        if (diff < 0) {
            commands ~= [R[i], C[i], nr, nc];
            best_score += diff;
            swap(A[R[i]][C[i]], A[nr][nc]);
            if (j == -1) R[i] = nr, C[i] = nc;
            else swap(R[i], R[j]), swap(C[i], C[j]);
            K--;
            if (K == 0) break;
        }
    }

    commands.each!(c => c.map!(b => b.to!string).join(" ").writeln);
}
