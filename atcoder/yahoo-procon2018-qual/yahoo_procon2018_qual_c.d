import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto X = readln.split.map!(to!long).array;
    auto C = readln.split.map!(to!long).array;
    auto V = readln.split.map!(to!long).array;

    auto XX = new long[](N+1);
    foreach (i; 0..N) {
        XX[i+1] = XX[i] + X[i];
    }

    auto CC = new long[](1<<N);
    auto VV = new long[](1<<N);
    foreach (mask; 0..(1<<N)) {
        foreach (i; 0..N) {
            if (mask & (1<<i)) {
                CC[mask] += C[i];
                VV[mask] += V[i];
            }
        }
    }

    auto dp = new long[][](N+1, 1<<N);
    foreach (x; 0..N+1) {
        foreach (mask; 0..(1<<N)) {
            if (XX[x] >= CC[mask]) {
                dp[x][mask] = max(dp[x][mask], VV[mask]);
            }
            foreach (i; 0..N) {
                if (mask & (1 << i)) {
                    dp[x][mask] = max(dp[x][mask], dp[x][mask^(1<<i)]);
                }
            }
        }
    }

    auto mem = new long[](1<<N);
    fill(mem, -1);

    long solve(int mask, int cnt) {
        long ret = dp[N-cnt][mask];
        if (cnt == 0) return 0;
        if (mem[mask] >= 0) return mem[mask];
        long ret2 = 1L << 59;
        foreach (i; 0..N) if (mask & (1<<i)) ret2 = min(ret2, solve(mask^(1<<i), cnt-1));
        mem[mask] = max(ret2, ret);
        return max(ret2, ret);
    }

    solve((1<<N)-1, N).writeln;
}


class BIT{
    int n;
    real[] table;

    this(int n){
        this.n = n;
        table = new real[](n+1);
    }

    void add(int i, real x){
        i++;
        while (i <= n){
            table[i] += x;
            i += i & -i;
        }
    }

    // [l, r)
    void add(int l, int r, real x) {
        add(l, x);
        add(r, -x);
    }

    // [0, i]
    real sum(int i){
        i++;
        real ret = 0;
        while (i > 0){
            ret += table[i];
            i -= i & -i;
        }
        return ret;
    }

    // [l, r)
    real sum(int l, int r){
        if (l >= r) return 0;
        return sum(r-1) - sum(l-1);
    }
}
