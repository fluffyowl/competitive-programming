import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


int N, K;
real[][][] mem;

real dp(int left, int cap, bool ateMax) { //残りがleft枚あって、あとcap枚食べられる
    if (cap < 0) return 0;
    if (left == 0) return ateMax ? 1.0L : 0;
    if (mem[left][cap][ateMax] >= 0) return mem[left][cap][ateMax];

    real maxp = 1.0L / (N - left + 1);

    // MAXじゃないので食べない
    real p1 = (1 - maxp) * dp(left-1, cap, ateMax);
    
    // MAXだけど食べない
    real p2 = maxp * dp(left-1, cap, 0);

    // MAXで食べる
    real p3 = maxp * dp(left-1, cap-1, 1);
    
    return mem[left][cap][ateMax] = p1 + max(p2, p3);
}

void main() {
    scanf("%d %d", &N, &K);

    mem = new real[][][](N+1, K+1, 2);
    foreach (i; 0..N+1) foreach (j; 0..K+1) fill(mem[i][j], -1);

    writefln("%.10f", dp(N, K, 0));
}
