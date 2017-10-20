import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!long);
    auto N = s[0].to!int;
    auto A = s[1];
    auto B = s[2];
    auto S = N.iota.map!(_ => readln.chomp.to!long).array;
    S ~= - 10L ^^ 18 - 10;
    S.sort();

    auto st1 = new SegmentTree(N + 1);
    auto st2 = new SegmentTree(N + 1);
    st1.add(0, 1);
    st2.add(0, 1);
    int lb1 = 0;
    int lb2 = 0;

    foreach (i; 2..N+1) {
        int j = S.assumeSorted.lowerBound(S[i] - A + 1).length.to!int - 1;
        int k = S.assumeSorted.lowerBound(S[i] - B + 1).length.to!int - 1;
        st2.add(i - 1, st1.sum(lb1, min(j, i - 2)));
        st1.add(i - 1, st2.sum(lb2, min(k, i - 2)));
        if (S[i] - S[i - 1] < A) lb2 = i - 1;
        if (S[i] - S[i - 1] < B) lb1 = i - 1;
    }

    writeln( (st1.sum(lb1, N + 1) + st2.sum(lb2, N + 1)) % MOD );
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
        (table[i] += num) %= MOD;
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
                (sum(pl, pr, i*2+1, left, (left+right)/2) +
                 sum(pl, pr, i*2+2, (left+right)/2+1, right)) % MOD;
    }
}
