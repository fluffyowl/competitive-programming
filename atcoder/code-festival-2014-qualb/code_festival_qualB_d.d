import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

const int INF = 1 << 29;

void main() {
    auto N = readln.chomp.to!int;
    auto H = N.iota.map!(_ => readln.chomp.to!int).array;

    int[][int] rev;
    foreach (i; 0..N) rev[H[i]] ~= i;

    auto st = new SegmentTree(N);
    foreach (i; 0..N) st.add(i, H[i]);

    auto ans = new int[](N);

    Tuple!(int, int)[] stack = [tuple(0, N-1)];

    while (!stack.empty) {
        auto l = stack.back[0];
        auto r = stack.back[1];
        stack.popBack;
        auto mx = st.sum(l, r);
        auto p = rev[mx].assumeSorted.lowerBound(l).length;
        auto last = l;

        for (; p < rev[mx].length && rev[mx][p] <= r; ++p) {
            int q = rev[mx][p];
            ans[q] = r - l;
            if (last < q) stack ~= tuple(last, q-1);
            last = q + 1;
        }

        if (last <= r) stack ~= tuple(last, r);
    }

    ans.each!writeln;
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
