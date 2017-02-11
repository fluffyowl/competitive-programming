import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

int X, Y, N;
int[] T, H;
int[][][] mem;

int dp(int n, int special, int normal) {
    if (n >= N || special <= 0)
        return 0;

    if (mem[n][special][normal] >= 0)
        return mem[n][special][normal];
    
    int use_normal = min(T[n]-1, normal);
    int use_special = T[n] - use_normal;
    if (special < use_special)
        mem[n][special][normal] = dp(n+1, special, normal);
    else
        mem[n][special][normal] = max(dp(n+1, special, normal),
                                      dp(n+1, special-use_special, normal-use_normal) + H[n]);

    return mem[n][special][normal];
}

void main(){
    scanf("%d %d", &X, &Y);
    scanf("%d", &N);
    T = new int[](N);
    H = new int[](N);
    foreach (i; 0..N)
        scanf("%d %d", &T[i], &H[i]);

    mem = new int[][][](N, 301, 301);
    foreach (i; 0..N) foreach (j; 0..301) foreach (k; 0..301) mem[i][j][k] = -1;
    dp(0, X, Y).writeln;
}
