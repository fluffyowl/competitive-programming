import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;


void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto T = s[2];
    s = readln.split.map!(to!int);
    auto sr = s[0];
    auto sc = s[1];
    s = readln.split.map!(to!int);
    auto gr = s[0];
    auto gc = s[1];
    auto A = H.iota.map!(_ => readln.chomp).array;

    int[] dr = [0, 0, 1, -1];
    int[] dc = [1, -1, 0, 0];

    auto cnt = new int[][](H, W);
    auto mat = new real[][](H*W, H*W);
    foreach (i; 0..H*W) foreach (j; 0..H*W) mat[i][j] = 0;

    foreach (r; 0..H) {
        foreach (c; 0..W) {
            if (A[r][c] == '#') continue;
            foreach (i; 0..4) {
                int nr = r + dr[i];
                int nc = c + dc[i];
                if (nr >= 0 && nr < H && nc >= 0 && nc < W && A[nr][nc] == '.') {
                    cnt[r][c] += 1;
                }
            }
        }
    }

    foreach (r; 0..H) {
        foreach (c; 0..W) {
            if (A[r][c] == '#') continue;
            if (cnt[r][c] == 0) {
                mat[r*W + c][r*W + c] = 1;
                continue;
            }
            foreach (i; 0..4) {
                int nr = r + dr[i];
                int nc = c + dc[i];
                if (nr >= 0 && nr < H && nc >= 0 && nc < W && A[nr][nc] == '.') {
                    mat[r*W + c][nr*W + nc] = 1.0L / cnt[r][c];
                }
            }
        }
    }

    //mat.each!writeln;
    auto ans = powmod(mat, T);
    writefln("%.09f", ans[sr*W + sc][gr*W + gc]);
}

real[][] mul(real[][] A, real[][] B) {
    auto n = A.length.to!int;
    auto ret = new real[][](n, n);
    foreach (i; 0..n) foreach (j; 0..n) ret[i][j] = 0;
    foreach (i; 0..n)
        foreach (j; 0..n)
            foreach (k; 0..n)
                ret[i][j] += A[i][k] * B[k][j];
    return ret;
}

real[][] powmod(real[][] A, long x) {
    auto n = A.length.to!int;
    auto ret = new real[][](n, n);
    foreach (i; 0..n) foreach (j; 0..n) ret[i][j] = i == j ? 1 : 0;
    while (x) {
        if (x % 2) ret = mul(ret, A);
        A = mul(A, A);
        x /= 2;
    }
    return ret;
}

