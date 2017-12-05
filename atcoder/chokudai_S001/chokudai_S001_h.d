import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;

    auto st = new SegmentTree(100001);

    foreach (i; 0..N) {
        auto x = st.sum(0, A[i] - 1);
        st.add(A[i], x + 1);
    }

    st.sum(0, 100001).writeln;
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
        if (left == right) {
            table[i] = num;
            return;
        }
        auto mid = (left + right) / 2;
        if (pos <= mid)
            add(pos, num, i*2+1, left, mid);
        else
            add(pos, num, i*2+2, mid+1, right);
        table[i] = max(table[i*2+1], table[i*2+2]);
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
                max(sum(pl, pr, i*2+1, left, (left+right)/2),
                    sum(pl, pr, i*2+2, (left+right)/2+1, right));
    }
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;

    auto st = new SegmentTree(100001);

    foreach (i; 0..N) {
        auto x = st.sum(0, A[i] - 1);
        st.add(A[i], x + 1);
    }

    st.sum(0, 100001).writeln;
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
        if (left == right) {
            table[i] = num;
            return;
        }
        auto mid = (left + right) / 2;
        if (pos <= mid)
            add(pos, num, i*2+1, left, mid);
        else
            add(pos, num, i*2+2, mid+1, right);
        table[i] = max(table[i*2+1], table[i*2+2]);
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
                max(sum(pl, pr, i*2+1, left, (left+right)/2),
                    sum(pl, pr, i*2+2, (left+right)/2+1, right));
    }
}
