import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.chomp).array;
    auto M = max(H, W) * 3 + 10;
    auto B = new long[][](M, M);
    auto C = new long[][](M, M);
    auto X = new int[][](M);
    auto Y = new int[][](M);
    long ans = 0;

    foreach (i; 0..H) {
        foreach (j; 0..W) {
            if (A[i][j] == '#') {
                int r = i + j + max(H, W);
                int c = i - j + max(H, W);
                B[r][c] = 1;
                C[r][c] = 1;
                X[r] ~= c;
                Y[c] ~= r;
            }
        }
    }

    foreach (i; 0..M) {
        foreach (j; 0..M-1) {
            B[i][j+1] += B[i][j];
        }
    }

    foreach (j; 0..M) {
        foreach (i; 0..M-1) {
            C[i+1][j] += C[i][j];
        }
    }

    foreach (i; 0..M) {
        foreach (j; 0..X[i].length) {
            foreach (k; j+1..X[i].length) {
                int len = X[i][k] - X[i][j];
                int a = X[i][j];
                int b = X[i][k];
                int u = i - len;
                int d = i + len;
                if (u >= 0) {
                    ans += B[u][b] - B[u][a-1];
                }
                if (d < M) {
                    ans += B[d][b] - B[d][a-1];
                }
            }
        }
    }

    foreach (i; 0..M) {
        foreach (j; 0..Y[i].length) {
            foreach (k; j+1..Y[i].length) {
                int len = Y[i][k] - Y[i][j];
                int a = Y[i][j];
                int b = Y[i][k];
                int u = i - len;
                int d = i + len;
                if (u >= 0) {
                    ans += C[b-1][u] - C[a][u];
                }
                if (d < M) {
                    ans += C[b-1][d] - C[a][d];
                }
            }
        }
    }

    ans.writeln;
}
