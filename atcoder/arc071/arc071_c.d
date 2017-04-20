import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


void main() {
    auto S = readln.chomp;
    auto T = readln.chomp;
    auto N = S.length.to!int;
    auto M = T.length.to!int;
    auto st = new SegmentTree(N);
    auto tt = new SegmentTree(M);
    foreach (i; 0..N) if (S[i] == 'A') st.add(i, 1);
    foreach (i; 0..M) if (T[i] == 'A') tt.add(i, 1);

    auto Q = readln.chomp.to!int;
    foreach (q; 0..Q) {
        auto s = readln.split.map!(to!int);
        auto a = s[0]-1;
        auto b = s[1]-1;
        auto c = s[2]-1;
        auto d = s[3]-1;
        auto n = b - a + 1;
        auto m = d - c + 1;
        auto sa = st.sum(a, b);
        auto sb = n - sa;
        auto ta = tt.sum(c, d);
        auto tb = m - ta;

        sa += sb * 2;
        ta += tb * 2;
        writeln((sa-ta)%3==0 ? "YES" : "NO");
    }
}


class SegmentTree {
    int[] table;
    int size;

    this(int n) {
        assert(bsr(n) < 29);
        size = 1 << (bsr(n) + 2);
        table = new int[](size);
    }

    void add(int pos, int num) {
        return add(pos, num, 0, 0, size/2-1);
    }

    void add(int pos, int num, int i, int left, int right) {
        table[i] += num;
        if (left == right)
            return;
        auto mid = (left + right) / 2;
        if (pos <= mid)
            add(pos, num, i*2+1, left, mid);
        else
            add(pos, num, i*2+2, mid+1, right);
    }

    int sum(int pl, int pr) {
        return sum(pl, pr, 0, 0, size/2-1);
    }

    int sum(int pl, int pr, int i, int left, int right) {
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
