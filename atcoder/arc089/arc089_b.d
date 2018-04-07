import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto B = new int[][](4*K+1, 4*K+1);
    auto W = new int[][](4*K+1, 4*K+1);
    auto P = new Tuple!(int, int, bool)[](N);
    foreach (i; 0..N) {
        auto S = readln.split;
        P[i] = tuple(S[0].to!int, S[1].to!int, S[2] == "B");
    }

    foreach (i; 0..N) {
        int x = P[i][0] % (2 * K);
        int y = P[i][1] % (2 * K);
        if (P[i][2]) {
            B[x+1][y+1] += 1;
            B[x+1][y+1+2*K] += 1;
            B[x+1+2*K][y+1] += 1;
            B[x+1+2*K][y+1+2*K] += 1;
        } else {
            W[x+1][y+1] += 1;
            W[x+1][y+1+2*K] += 1;
            W[x+1+2*K][y+1] += 1;
            W[x+1+2*K][y+1+2*K] += 1;
        }
    }

    foreach (i; 0..4*K+1)
        foreach (j; 0..4*K)
            B[i][j+1] += B[i][j];
    foreach (j; 0..4*K+1)
        foreach (i; 0..4*K)
            B[i+1][j] += B[i][j];

    foreach (i; 0..4*K+1)
        foreach (j; 0..4*K)
            W[i][j+1] += W[i][j];
    foreach (j; 0..4*K+1)
        foreach (i; 0..4*K)
            W[i+1][j] += W[i][j];

    int acm(int x1, int y1, int x2, int y2, int[][] A) {
        return A[x2+1][y2+1] - A[x2+1][y1] - A[x1][y2+1] + A[x1][y1];
    }


    int ans = 0;

    foreach (i; 0..2*K) {
        foreach (j; 0..2*K) {
            int b = acm(i, j, i+K-1, j+K-1, B) + acm(i+K, j+K, i+2*K-1, j+2*K-1, B);
            int w = acm(i, j+K, i+K-1, j+2*K-1, W) + acm(i+K, j, i+2*K-1, j+K-1, W);
            ans = max(ans, b + w);
        }
    }

    ans.writeln;
}
