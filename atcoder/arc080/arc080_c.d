import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

alias Tuple!(int, "a", int, "l", int, "r") Seg;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    auto B = new int[](N+1);
    foreach (i; 0..N) B[A[i]] = i;

    auto st1 = new SegmentTree(N + 1);
    auto st2 = new SegmentTree(N + 1);

    for (int i = 0; i < N; i += 2) st1.assign(i, A[i]);
    for (int i = 0; i < N; i += 2) st2.assign(i+1, A[i+1]);

    int query(int l, int r) {
        if (l % 2 == 0) return st1.query(l, r);
        else return st2.query(l, r);
    }

    auto ans = new int[](N);
    int p = 0;

    auto pq = new BinaryHeap!(Array!Seg, "a[0] > b[0]");
    pq.insert(Seg(query(0, N-1), 0, N-1));

    while (!pq.empty) {
        auto seg = pq.front;
        pq.popFront;
        auto l = seg.l;
        auto r = seg.r;
        int a = seg.a;
        int ai = B[a];
        int b = query(ai+1, r);
        int bi = B[b];
        ans[p++] = a;
        ans[p++] = b;
        if (ai != l) pq.insert(Seg(query(l, ai-1), l, ai-1));
        if (bi != r) pq.insert(Seg(query(bi+1, r), bi+1, r));
        if (ai + 1 != bi) pq.insert(Seg(query(ai+1, bi-1), ai+1, bi-1));
    }

    ans.map!(a => a.to!string).join(" ").writeln;
}


class SegmentTree {
    int[] table;
    int size;
    immutable int INF = 1 << 29;

    this(int n) {
        assert(bsr(n) < 29);
        size = 1 << (bsr(n) + 2);
        table = new int[](size);
        fill(table, INF);
    }

    void assign(int pos, int num) {
        return assign(pos, num, 0, 0, size/2-1);
    }

    void assign(int pos, int num, int i, int left, int right) {
        if (left == right) {
            table[i] = num;
            return;
        }
        auto mid = (left + right) / 2;
        if (pos <= mid)
            assign(pos, num, i*2+1, left, mid);
        else
            assign(pos, num, i*2+2, mid+1, right);
        table[i] = min(table[i * 2 + 1], table[i * 2 + 2]);
    }

    int query(int pl, int pr) {
        return query(pl, pr, 0, 0, size/2-1);
    }

    int query(int pl, int pr, int i, int left, int right) {
        if (pl > right || pr < left)
            return INF;
        else if (pl <= left && right <= pr)
            return table[i];
        else
            return
                min(query(pl, pr, i*2+1, left, (left+right)/2),
                    query(pl, pr, i*2+2, (left+right)/2+1, right));
    }
}
