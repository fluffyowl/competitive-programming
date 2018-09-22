import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;

    int hi = A.reduce!max + 2;
    int lo = A.reduce!min - 2;
    long seg = (1L * N * (N - 1) / 2 + N);
    seg = (seg - 1) / 2 + 1;

    while (hi - lo > 1) {
        int mid = (hi + lo) / 2;
        auto st = new SegmentTree(N*3, N);
        auto B = A.map!(a => a >= mid ? 1 : -1).array;
        int offset = 0;
        long ans = 0;
        foreach (i; 0..N) {
            offset += B[i];
            st.add(B[i] - offset, 1);
            ans += st.sum(-offset, N);
        }
        (ans >= seg ? lo : hi) = mid;
    }

    lo.writeln;
}


class SegmentTree {
    long[] table;
    int size;
    int hoge;

    this(int n, int hoge) {
        assert(bsr(n) < 29);
        size = 1 << (bsr(n) + 2);
        table = new long[](size);
        this.hoge = hoge;
    }

    void add(int pos, long num) {
        pos += hoge;
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
        pl += hoge;
        pr += hoge;
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
