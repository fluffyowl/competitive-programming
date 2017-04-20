import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable int N = 10;
char[N][N] B;
int[16] dr = [-2, -2, -2, -1, -1, -1, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2];
int[16] dc = [-2, 0, 2, -1, 0, 1, -2, -1, 1, 2, -1, 0, 1, -2, 0, 2];

void put(int r, int c) {
    B[r][c] = 'C';
    foreach (i; 0..16) {
        auto nr = r + dr[i];
        auto nc = c + dc[i];
        if (nr < 0 || nr >= N || nc < 0 || nc >= N) continue;
        if (B[nr][nc] == 'C') continue;
        B[nr][nc] = 'X';
    }
}

void main() {
    foreach (a; 0..100) {
        foreach (b; a+1..100) {
            foreach (c; b+1..100) {
                foreach (d; c+1..100) {
                    foreach (i; 0..N) foreach (j; 0..N) B[i][j] = '.';
                    put(a/10, a%10);
                    put(b/10, b%10);
                    put(c/10, c%10);
                    put(d/10, d%10);
                    auto dp = new int[][](N, N);
                    foreach (i; 0..N) dp[i][0] = B[i][0] == '.' ? 1 : 0;
                    foreach (j; 0..N-1) {
                        foreach (i; 0..N) {
                            if (i - 1 >= 0 && B[i-1][j+1] == '.') dp[i-1][j+1] += dp[i][j];
                            if (B[i][j+1] == '.') dp[i][j+1] += dp[i][j];
                            if (i + 1 < N && B[i+1][j+1] == '.') dp[i+1][j+1] += dp[i][j];
                        }
                    }
                    auto s = 0;
                    foreach (i; 0..N) s += dp[i][N-1];
                    if (s == 1) {
                        foreach (i; 0..N)
                            foreach (j; 0..N)
                                if (B[i][j] == 'X')
                                    B[i][j] = '.';
                        B.each!writeln;
                        return;
                    }
                }
            }
        }
    }
}
