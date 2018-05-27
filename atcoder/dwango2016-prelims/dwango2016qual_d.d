import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable long INF = 1L << 59;
    
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.split.map!(to!long).array).array;

    auto B = new long[][](H+1, W+1);
    foreach (i; 0..H) foreach (j; 0..W) B[i+1][j+1] = B[i+1][j] + A[i][j];
    foreach (j; 0..W) foreach (i; 0..H) B[i+1][j+1] += B[i][j+1];

    long acm(int r1, int c1, int r2, int c2) {
        return B[r2+1][c2+1] - B[r2+1][c1] - B[r1][c2+1] + B[r1][c1];
    }

    auto dpH = new long[][](H, H);
    auto dpW = new long[][](W, W);
    auto tmp = new long[](max(H, W) + 1);
    foreach (i; 0..H) dpH[i].fill(-INF);
    foreach (i; 0..W) dpW[i].fill(-INF);

    foreach (r1; 0..H) {
        foreach (r2; r1..H) {
            tmp.fill(0);
            foreach (j; 0..W) {
                tmp[j+1] = acm(r1, 0, r2, j);
            }
            long mn = 0;
            foreach (j; 0..W) {
                dpH[r1][r2] = max(dpH[r1][r2], tmp[j+1] - mn);
                mn = min(mn, tmp[j+1]);
            }
        }
    }

    foreach (c1; 0..W) {
        foreach (c2; c1..W) {
            tmp.fill(0);
            foreach (j; 0..H) {
                tmp[j+1] = acm(0, c1, j, c2);
            }
            long mn = 0;
            foreach (j; 0..H) {
                dpW[c1][c2] = max(dpW[c1][c2], tmp[j+1] - mn);
                mn = min(mn, tmp[j+1]);
            }
        }
    }

    
    auto dpH2 = new long[][](H, H);
    auto dpW2 = new long[][](W, W);
    foreach (i; 0..H) dpH2[i].fill(-INF);
    foreach (i; 0..W) dpW2[i].fill(-INF);

    foreach (r1; 0..H) {
        dpH2[r1][r1] = dpH[r1][r1];
        foreach (r2; r1+1..H) {
            dpH2[r1][r2] = max(dpH2[r1][r2-1], dpH[r1][r2]);
        }
    }
    
    foreach (c1; 0..W) {
        dpW2[c1][c1] = dpW[c1][c1];
        foreach (c2; c1+1..W) {
            dpW2[c1][c2] = max(dpW2[c1][c2-1], dpW[c1][c2]);
        }
    }

    long ans = -INF;
    foreach (r1; 0..H) foreach (r2; r1+1..H) ans = max(ans, dpH2[r1][r2-1] + dpH2[r2][H-1]);
    foreach (c1; 0..W) foreach (c2; c1+1..W) ans = max(ans, dpW2[c1][c2-1] + dpW2[c2][W-1]);
    ans.writeln;
}
