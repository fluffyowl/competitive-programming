import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    auto LR = N.iota.map!(_ => readln.split.map!(to!long).array).array;

    long[] tmp = [-10L^^10];
    int[long] comp;
    foreach (i; 0..N) {
        tmp ~= A[i];
        tmp ~= A[i] - LR[i][0];
        tmp ~= A[i] + LR[i][1];
    }
    tmp = tmp.sort().uniq().array;
    foreach (i; 0..tmp.length) {
        comp[tmp[i]] = i.to!int;
    }
    int M = tmp.length.to!int;

    auto pq = new BinaryHeap!(Array!(Tuple!(long, long, long)), "a[2] > b[2]")();
    auto st = new SegmentTree(M);
    long ans = 0;

    foreach (i; 0..N) {
        while (!pq.empty && pq.front[2] < A[i]) {
            st.add(comp[pq.front[1]], -1);
            pq.removeFront;
        }
        ans += st.sum(comp[A[i] - LR[i][0]], comp[A[i]]);
        st.add(comp[A[i]], 1);
        pq.insert(tuple(A[i] - LR[i][0], A[i], A[i] + LR[i][1]));
    }

    ans.writeln;
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

