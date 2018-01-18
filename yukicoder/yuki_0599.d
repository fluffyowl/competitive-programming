import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

const long MOD = 10^^9 + 7;
const long BASE = 97;


void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;

    auto powmod = new long[](N+1);
    powmod[0] = 1;
    foreach (i; 0..N)
        powmod[i+1] = powmod[i] * BASE % MOD;


    auto same = new bool[][](N+1, N/2);

    foreach (k; 1..N+1) {
        auto table = new long[](N-k+2);
        long hash = 0;
        foreach (i; 0..k) {
            hash = hash * BASE % MOD;
            hash = (hash + S[i]-'a') % MOD;
        }
        table[0] = hash;

        foreach (i; 1..N-k+1) {
            hash = hash - (S[i-1] - 'a') * powmod[k-1] % MOD;
            hash = hash * BASE % MOD;
            hash = (hash + S[i+k-1]-'a') % MOD;
            hash = (hash + MOD) % MOD;
            table[i] = hash;
        }

        foreach (i; 0..N/2)
            if (N-i-1-k+1 < 0)
                break;
            else
                same[k][i] = table[i] == table[N-i-1-k+1];
    }


    auto mem = new long[](N/2);
    mem.fill(-1);

    long dfs(int l) {
        if (l >= N/2)
            return 0;
        if (mem[l] >= 0)
            return mem[l];

        int r = N - l - 1;
        long ret = 0;

        foreach (len; 1..N) {
            if (l+len-1 >= N/2)
                break;
            if (same[len][l])
                (ret += dfs(l+len) + 1) %= MOD;
        }
        mem[l] = ret;
        return ret;
    }

    writeln((dfs(0)+1)%MOD);
}

