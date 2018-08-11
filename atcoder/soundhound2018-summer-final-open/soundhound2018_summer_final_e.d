import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;
immutable long BASE = 10^^6;
immutable int SIZE = 450;
long BUCKET_BASE;

class Node {
    long big;
    long[] small;

    this(string s) {
        small = new long[](SIZE);
        foreach (i; 0..s.length) {
            small[i] = s[i] - 'a' + 1;
        }
        hash;
    }

    void hash() {
        big = 0;
        foreach_reverse (i; 0..SIZE) {
            big = big * BASE % MOD;
            big = (big + small[i]) % MOD;
        }
    }
}


long calc(const Node[] str, int l, int r) {
    long ret = 0;
    foreach_reverse (i; l/SIZE..(r-1)/SIZE+1) {
        int bl = i * SIZE;
        int br = i * SIZE + SIZE;
        if (l > bl || r < br) {
            foreach_reverse (j; max(l, bl)..min(r, br)) {
                ret = ret * BASE % MOD;
                ret = (ret + str[i].small[j%SIZE]) % MOD;
            }
        } else {
            ret = ret * BUCKET_BASE % MOD;
            ret = (ret + str[i].big) % MOD;
        }
    }
    return ret;
}

void nswap(Node[] x, Node[] y, int l, int r) {
    foreach (i; l/SIZE..(r-1)/SIZE+1) {
        int bl = i * SIZE;
        int br = i * SIZE + SIZE;
        if (l > bl || r < br) {
            foreach (j; max(l, bl)..min(r, br)) {
                swap(x[i].small[j%SIZE], y[i].small[j%SIZE]);
            }
            x[i].hash;
            y[i].hash;
        } else {
            swap(x[i].big, y[i].big);
            swap(x[i].small, y[i].small);
        }
    }
}

long powmod(long a, long x, long m) {
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

void main() {
    BUCKET_BASE = powmod(BASE, SIZE, MOD);
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto S = M.iota.map!(_ => readln.chomp).array;
    
    auto strs = new Node[][](M, SIZE);
    foreach (i; 0..M) 
        foreach (j; 0..SIZE) 
            if (j*SIZE < N) 
                strs[i][j] = new Node(S[i][j*SIZE..min(N, j*SIZE+SIZE)]);
    
    auto Q = readln.chomp.to!int;
    
    while (Q--) {
        auto q = readln.split.map!(to!int);
        int type = q[0];
        int x = q[1] - 1;
        int y = q[2] - 1;
        int l = q[3] - 1;
        int r = q[4];
        
        if (type == 1) {
            nswap(strs[x], strs[y], l, r);
        } else {
            calc(strs[x], l, r).writeln;
        }
    }
}
