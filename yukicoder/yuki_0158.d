import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

int[2] cost, A, B, C;
int[][][] mem;

int dp(int a, int b, int c) {
    if (mem[a][b][c] >= 0) return mem[a][b][c];
    int ret = 0;
    foreach (i; 0..2) {
        foreach (j; 0..a+1) {
            foreach (k; 0..b+1) {
                int oneyen = cost[i] - j * 1000 - k * 100;
                if (oneyen < 0) break;
                if (oneyen > c) continue;
                ret = max(ret, dp(a-j+A[i], b-k+B[i], c-oneyen+C[i]) + 1);
            }
        }
    }
    return mem[a][b][c] = ret;
}

void main() {
    int a, b, c;
    scanf("%d %d %d", &a, &b, &c);
    scanf("%d", &cost[0]);
    scanf("%d %d %d", &A[0], &B[0], &C[0]);
    scanf("%d", &cost[1]);
    scanf("%d %d %d", &A[1], &B[1], &C[1]);
    mem = new int[][][](11, 101, 10001);
    foreach (i; 0..11) foreach (j; 0..101) foreach (k; 0..10001) mem[i][j][k] = -1;
    dp(a, b, c).writeln;
}

