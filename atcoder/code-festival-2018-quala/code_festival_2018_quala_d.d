import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!int);
    auto D = s[0].to!long;
    auto F = s[1].to!long;
    auto T = s[2].to!long;
    auto N = s[3];
    auto A = 0 ~ readln.split.map!(to!long).array;
    N += 1;

    auto P2 = new long[](N+1);
    P2[0] = 1;
    foreach (i; 0..N) P2[i+1] = P2[i] * 2 % MOD;

    auto bt = new BIT(N+1);
    bt.add(0, 1);
    bt.add(1, -1);
    long ans = 0;

    foreach (i; 0..N) {
        auto ub = A.assumeSorted.lowerBound(A[i] + F + 1).length.to!int;
        auto lb = A.assumeSorted.lowerBound(A[i] + F - T + 1).length.to!int;
        long num = bt.sum(0, i+1) * P2[max(0, lb - i - 1)] % MOD;
        bt.add(lb, num);
        bt.add(ub, -num);
        if (D - A[i] <= F) ans = (ans + num) % MOD;
    }

    ans = (ans % MOD + MOD) % MOD;
    ans.writeln;
}


class BIT{
    int n;
    long[] table;

    this(int x){
        n = x;
        table = new long[](x+1);
    }

    void add(int i, long x){
        i++;
        while (i <= n){
            (table[i] += x) %= MOD;
            i += i & -i;
        }
    }

    // [0, i]
    long sum(int i){
        i++;
        long ret = 0;
        while (i > 0){
            (ret += table[i]) %= MOD;
            i -= i & -i;
        }
        return ret;
    }

    // [l, r)
    long sum(int l, int r){
        if (l >= r) return 0;
        return (sum(r-1) - sum(l-1)) % MOD;
    }
}
