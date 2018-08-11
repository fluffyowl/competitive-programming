import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable long MOD = 10^^9 + 7;
    
    auto N = readln.chomp.to!int;
    auto Q = readln.chomp.to!int;
    auto B = new long[](N+10);
    auto X = new long[](N+10);
    auto Y = new long[](N+10);
    auto Z = new SegmentTree!(long, (a, b) => a + b, 0L)(N+10);
    fill(B, 1);

    while (Q--) {
        auto s = readln.split;
        int i = s[1].to!int;
        if (s[0] == "x") {
            long v = s[2].to!long;
            X[i] = v;
            Z.update(i, v * B[i] % MOD * B[i] % MOD);
        } else if (s[0] == "y") {
            long v = s[2].to!long;
            Y[i] = v;
            B[i+1] = (B[i] * Y[i] + 1) % MOD;
            Z.update(i+1, X[i+1] * B[i+1] % MOD * B[i+1] % MOD);
            i += 1;
            while (i < N) {
                B[i+1] = (B[i] * Y[i] + 1) % MOD;
                Z.update(i+1, X[i+1] * B[i+1] % MOD * B[i+1] % MOD);
                if (Y[i] == 0) break;
                i += 1;
            }
        } else {
            writeln((Z.query(0, i-1) + 1) % MOD);
        }
    }
}

class SegmentTree(T, alias op, T e) {
    T[] table;
    int size;
    int offset;

    this(int n) {
        size = 1;
        while (size <= n) size <<= 1;
        size <<= 1;
        table = new T[](size);
        fill(table, e);
        offset = size / 2;
    }

    void update(int pos, T val) {
        pos += offset;
        table[pos] = val;
        while (pos > 1) {
            pos /= 2;
            table[pos] = op(table[pos*2], table[pos*2+1]);
        }
    }

    T query(int l, int r) {
        return query(l, r, 1, 0, offset-1);
    }

    T query(int l, int r, int i, int a, int b) {
        if (b < l || r < a) {
            return e;
        } else if (l <= a && b <= r) {
            return table[i];
        } else {
            return op(query(l, r, i*2, a, (a+b)/2), query(l, r, i*2+1, (a+b)/2+1, b));
        }
    }
}

