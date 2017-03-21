import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto s = readln.split;
    auto N = s[0].to!int;
    auto Q = s[1].to!int;

    int M = 2 * N;
    auto st = new SegmentTree(2*N);
    int sym(int n) {return 2*N-n-1;}
    int rot(int n, int t) {
        int pos = (n - t) % M;
        pos = (pos + M) % M;
        return pos;
    }

    foreach (q; 1..Q+1) {
        s = readln.split;
        auto x = s[0];
        auto t = s[1].to!int;
        auto y = s[2].to!int;
        auto z = s[3].to!int;
        
        if (x == "L") {
            int pos = rot(sym(y), t);
            st.add(pos, z);
        }
        else if (x == "R") {
            int pos = rot(y, t);
            st.add(pos, z);
        }
        else {
            int l1 = rot(y, t);
            int r1 = rot(z-1, t);
            int l2 = rot(sym(y), t);
            int r2 = rot(sym(z-1), t);
            long ans = 0;
            if (l1 <= r1)
                ans += st.sum(l1, r1);
            else 
                ans += st.sum(l1, M-1) + st.sum(0, r1);
            if (r2 <= l2)
                ans += st.sum(r2, l2);
            else
                ans += st.sum(r2, M-1) + st.sum(0, l2);
            ans.writeln;
        }
    }
}

class SegmentTree {
    long[] table;
    int size;

    this(int n) {
        assert(bsr(n) < 29);
        size = 1 << (bsr(n) + 2);
        table = new long[](size);
        fill(table, 0);
    }

    void add(int pos, long num) {
        return add(pos, num, 0, 0, size/2-1);
    }

    void add(int pos, long num, int i, int left, int right) {
        table[i] += num;
        if (left == right)
            return;
        auto mid = (left + right) / 2;
        if (pos <= mid)
            add(pos, num, i*2+1, left, mid);
        else
            add(pos, num, i*2+2, mid+1, right);
    }

    long sum(int pl, int pr) {
        return sum(pl, pr, 0, 0, size/2-1);
    }

    long sum(int pl, int pr, int i, int left, int right) {
        if (pl > right || pr < left)
            return 0;
        else if (pl <= left && right <= pr)
            return table[i];
        else
            return
                sum(pl, pr, i*2+1, left, (left+right)/2) +
                sum(pl, pr, i*2+2, (left+right)/2+1, right);
    }
}

