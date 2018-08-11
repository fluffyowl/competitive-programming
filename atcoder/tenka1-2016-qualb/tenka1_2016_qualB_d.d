import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

alias Tuple!(int, "t", int, "l", int, "r", int, "x") Query;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    auto q1 = readln.chomp.to!int;
    auto Q1 = q1.iota.map!(i => (i+1) ~ readln.split.map!(to!int).array).array;
    auto q2 = readln.chomp.to!int;
    auto Q2 = q2.iota.map!(i => (i+1) ~ readln.split.map!(to!int).array).array;
    auto st = new LazySegmentTree!long(q1+10);
    auto ans = new long[](q2);

    auto add_queue1 = new BinaryHeap!(Array!Query, "a.l > b.l");
    auto add_queue2 = new BinaryHeap!(Array!Query, "a.r > b.r");
    foreach (q; Q1) add_queue1.insert(Query(q[0], q[1], q[2], q[3]));
    Q2.sort!"a[3] < b[3]";
    int p = 0;

    foreach (i; 1..N+1) {
        while (!add_queue2.empty && add_queue2.front.r < i) {
            auto q = add_queue2.front;
            add_queue2.removeFront;
            st.add(q.t, q1+1, -q.x);
        }
        while (!add_queue1.empty && add_queue1.front.l == i) {
            auto q = add_queue1.front;
            add_queue1.removeFront;
            st.add(q.t, q1+1, q.x);
            add_queue2.insert(q);
        }
        while (p < q2 && Q2[p][3] == i) {
            ans[Q2[p][0]-1] = st.getVal(Q2[p][1]-1, Q2[p][2]) + A[i-1];
            ++p;
        }
    }

    ans.each!writeln;
}

class LazySegmentTree(T) {
    T[] table;
    T[] lazy_;
    int size;

    this(int n) {
        assert(bsr(n) < 29);
        size = 1 << (bsr(n) + 2);
        table = new T[](size);
        lazy_ = new T[](size);
        fill(table, 0);
        fill(lazy_, 0);
    }

    void eval(int i, int l, int r) {
        if (lazy_[i] == 0) return;

        table[i] += lazy_[i];
        if (l != r) {
            lazy_[i*2+1] += lazy_[i];
            lazy_[i*2+2] += lazy_[i];
        }

        lazy_[i] = 0;
    }

    void add(int a, int b, T num) {
        add(a, b, num, 0, 0, size/2-1);
    }

    void add(int a, int b, T num, int i, int l, int r) {
        eval(i, l, r);

        if (a > r || b < l) return;
        if (a <= l && r <= b) {
            lazy_[i] += num;
            eval(i, l, r);
        } else {
            add(a, b, num, i*2+1, l, (l+r)/2);
            add(a, b, num, i*2+2, (l+r)/2+1, r);
            table[i] = min(table[i*2+1], table[i*2+2]);
        }
    }

    T getVal(int a, int b) {
        return getVal(a, b, 0, 0, size/2-1);
    }

    T getVal(int a, int b, int i, int l, int r) {
        eval(i, l, r);

        if (a > r || b < l) return 1L << 59;
        if (a <= l && r <= b) return table[i];
        return
            min(getVal(a, b, i*2+1, l, (l+r)/2),
                getVal(a, b, i*2+2, (l+r)/2+1, r));
    }
}
