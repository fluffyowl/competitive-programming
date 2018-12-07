import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

const int[] dr = [0, 0, -1, 1];
const int[] dc = [1, -1, 0, 0];
const bool[][] X = [[false, true, false, false],
                    [false, false, false, true],
                    [true, false, false, false],
                    [false, true, false, false]];
const int[] er = [0, 1, 2, 3];
const int[] ec = [1, 3, 0, 2];

void main() {
    auto N = readln.chomp.to!int;
    auto A = new bool[][](N, N);

    int start = 0;
    for (int j = 0; j < N; j += 4) {
        for (int i = start; i < N; i += 5) {
            foreach (k; 0..4) {
                int ni = i + er[k];
                int nj = j + ec[k];
                if (ni >= N || nj >= N) continue;
                A[ni][nj] = true;
            }
        }
        start = (start + 2) % 5;
    }

    foreach (i; 0..N) {
        foreach (j; 0..N) {
            if (A[i][j]) continue;
            bool ok = false;
            foreach (k; 0..4) {
                int ni = i + dr[k];
                int nj = j + dc[k];
                if (ni >= 0 && ni < N && nj >= 0 && nj < N && A[ni][nj]) ok = true;
            }
            if (!ok) A[i][j] = true;
        }
    }

    foreach (i; 0..N) {
        A[i].map!(a => a ? 'X' : '.').writeln;
    }

    //int x = 0;
    //foreach (a; A) foreach (b; a) x += b;
    //x.writeln;
}
