import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.chomp.to!int).array;
    auto B = A.dup;
    B = B.sort().uniq().array;
    int[int] comp;
    foreach (i, b; B.enumerate) comp[b] = i.to!int;
    foreach (i; 0..N) A[i] = comp[A[i]];

    int M = comp.keys.length.to!int;
    auto st = new SegmentTree(M+1);
    long ans = 0;

    foreach_reverse (i; 0..N) {
        ans += st.sum(0, A[i]-1);
        st.add(A[i], 1);
    }

    foreach (i; 0..N) {
        ans.writeln;
        ans -= st.sum(0, A[i]-1);
        ans += st.sum(A[i]+1, M+1);
    }
}


class SegmentTree {
    long[] table;
    int size;

    this(int n) {
        assert(bsr(n) < 29);
        size = 1 << (bsr(n) + 2);
        table = new long[](size);
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
        if (pl > pr) return 0;
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

