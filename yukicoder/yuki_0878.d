import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto Q = s[1];
    auto A = readln.split.map!(to!long).array;

    auto pq = new BinaryHeap!(Array!(Tuple!(long, int)), "a[0] > b[0]");
    auto B = new Tuple!(int, int)[](N);

    foreach_reverse (i, a; A) {
        while (!pq.empty && pq.front[0] < a) {
            B[pq.front[1]] = tuple(i.to!int, pq.front[1]);
            pq.removeFront;
        }
        pq.insert(tuple(a, i.to!int));
    }
    while (!pq.empty) {
        B[pq.front[1]] = tuple(-1, pq.front[1]);
        pq.removeFront;
    }
    B.sort!"a[0] < b[0]";

    auto X = Q.iota.map!(i => readln.split.map!(to!int).array ~ i).array;
    X.sort!"a[1] < b[1]";
    auto st = new SegmentTree!(long, (a,b)=>a+b, 0L)(N);
    auto ans = new long[](Q);
    int p = 0;

    foreach (x; X) {
        auto il = x[1] - 1;
        auto ir = x[2] - 1;
        auto idx = x[3];
        while (p < N && B[p][0] < il) {
            st.assign(B[p][1], 1L);
            p += 1;
        }
        ans[idx] = st.query(il, ir);
    }

    ans.each!writeln;
}

class SegmentTree(T, alias op, T e) {
    T[] table;
    int size;
    int offset;

    this(int n) {
        size = 1;
        while (size <= n) size <<= 1;
        size <<= 1;
        table = new T[](size);
        fill(table, e);
        offset = size / 2;
    }

    void assign(int pos, T val) {
        pos += offset;
        table[pos] = val;
        while (pos > 1) {
            pos /= 2;
            table[pos] = op(table[pos*2], table[pos*2+1]);
        }
    }

    void add(int pos, T val) {
        pos += offset;
        table[pos] += val;
        while (pos > 1) {
            pos /= 2;
            table[pos] = op(table[pos*2], table[pos*2+1]);
        }
    }

    T query(int l, int r) {
        return query(l, r, 1, 0, offset-1);
    }

    T query(int l, int r, int i, int a, int b) {
        if (b < l || r < a) {
            return e;
        } else if (l <= a && b <= r) {
            return table[i];
        } else {
            return op(query(l, r, i*2, a, (a+b)/2), query(l, r, i*2+1, (a+b)/2+1, b));
        }
    }
}

