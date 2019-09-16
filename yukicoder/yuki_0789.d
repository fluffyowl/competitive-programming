import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto Q = N.iota.map!(_ => readln.split.map!(to!long).array).array;

    long[] B;
    foreach (q; Q) if (q[0] == 1) B ~= q[1], B ~= q[2]; else B ~= q[1];
    B = B.sort().uniq.array;

    int[long] mp;
    foreach (i, b; B) mp[b] = i.to!int;

    auto st = new SegmentTree!(long, (a,b)=>a+b, 0L)(B.length.to!int);
    long ans = 0;

    foreach (q; Q) {
        if (q[0] == 0) {
            auto x = mp[q[1]];
            auto y = q[2];
            st.add(x, y);
        } else {
            auto l = mp[q[1]];
            auto r = mp[q[2]];
            ans += st.query(l, r);
        }
    }

    ans.writeln;
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

