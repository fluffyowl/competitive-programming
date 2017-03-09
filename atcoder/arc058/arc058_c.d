import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;
import std.datetime;
 
 
immutable long MOD = 10^^9 + 7;

int N, X, Y, Z, S, MASK, NG;
long[][] mem;


long dp(int n, int mask) {
    if (n >= N) return 1;
    if (mem[n][mask] >= 0) return mem[n][mask];

    long ret = 0;
    foreach (i; 1..11) {
        //if (i == ng) continue;
        int n_mask = (mask << i) | (1 << (i - 1));
        if ((n_mask & NG) == NG) continue;
        n_mask &= MASK;
        ret = (ret + dp(n+1, n_mask)) % MOD;
    }

    return mem[n][mask] = ret;
}


void main() {
    scanf("%d %d %d %d", &N, &X, &Y, &Z);
    
    S = X + Y + Z;
    mem = new long[][](N, 1<<S);
    foreach (i; 0..N) fill(mem[i], -1);
    MASK = (1 << S) - 1;

    NG |= (1 << (Z-1));
    NG |= (1 << (Y+Z-1));
    NG |= (1 << (X+Y+Z-1));

    long ans = 1;
    foreach (i; 0..N) ans = (ans * 10) % MOD;
    ans = ((ans - dp(0, 0)) % MOD + MOD) % MOD;

    ans.writeln;

}
