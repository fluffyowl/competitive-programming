import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = 16;
    auto A = N.iota.map!(_ => readln.split.map!(to!int).array).array;

    auto win = new bool[][](N, N);
    foreach (j; 0..N) {
        foreach (i; j+1..N) {
            win[j][i] = A[j][i] == 1;
            win[i][j] = !win[j][i];
        }
    }

    auto masks1 = new int[][](N+1);
    foreach (mask; 0..(1<<N)) masks1[mask.popcnt] ~= mask;

    auto masks = new int[][](1<<N);
    for (int cnt = N; cnt >= 2; cnt /= 2) {
        foreach (mask1; masks1[cnt/2]) {
            foreach (mask2; masks1[cnt]) {
                if ((mask1 & mask2) == mask1) {
                    masks[mask2] ~= mask1;
                }
            }
        }
    }

    auto mem = new long[][](1<<N, N);
    foreach (i; 0..(1<<N)) mem[i].fill(-1);

    foreach (i; 0..N) {
        foreach (j; 0..N) {
            if (i != j) {
                mem[(1<<i)|(1<<j)][i] = win[i][j] ? 2 : 0;
                mem[(1<<i)|(1<<j)][j] = win[j][i] ? 2 : 0;
            }
        }
    }

    long solve(int mask, int n) { // mask の山で勝者が n
        if (mem[mask][n] >= 0) return mem[mask][n];
        long ret = 0;
        foreach (left; masks[mask]) {
            if (!((1 << n) & left)) continue;
            int right = mask ^ left;
            foreach (i; 0..N) {
                if (((1 << i) & right) && win[n][i]) {
                    ret += solve(left, n) * solve(right, i) * 2;
                }
            }
        }
        mem[mask][n] = ret;
        return ret;
    }

    foreach (i; 0..N) solve((1<<N)-1, i).writeln;
}

