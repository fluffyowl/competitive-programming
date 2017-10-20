import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

alias Tuple!(long, "x", long, "y") Point;
immutable long MAX = 10^^8;

void main() {
    auto s = readln.split.map!(to!long);
    auto x1 = s[0], y1 = s[1], x2 = s[2], y2 = s[3];
    auto N = readln.chomp.to!int;
    auto P = new Point[](N);
    foreach (i; 0..N) {
        s = readln.split.map!(to!long);
        P[i] = Point(s[0], s[1]);
    }

    if (x1 > x2) swap(x1, x2), swap(y1, y2);
    if (y1 > y2) {
        y1 = MAX - y1;
        y2 = MAX - y2;
        foreach (i; 0..N) P[i].y = MAX - P[i].y;
    }

    if (x1 == x2) {
        real ans = (y2 - y1) * 100;
        bool hoge;
        foreach (i; 0..N) if (P[i].x == x1 && P[i].y >= y1 && P[i].y <= y2) hoge = true;
        if (hoge) {
            ans -= 20;
            ans += 10 * PI;
        }
        writefln("%.12f", ans);
        return;
    } else if (y1 == y2) {
        real ans = (x2 - x1) * 100;
        bool hoge;
        foreach (i; 0..N) if (P[i].y == y1 && P[i].x >= x1 && P[i].x <= x2) hoge = true;
        if (hoge) {
            ans -= 20;
            ans += 10 * PI;
        }
        writefln("%.12f", ans);
        return;
    }


    Point[] Q;
    foreach (i; 0..N) {
        if (P[i].x >= x1 && P[i].x <= x2 && P[i].y >= y1 && P[i].y <= y2) Q ~= P[i];
    }

    auto M = Q.length.to!int;
    Q.sort!"a[0] < b[0]"();
    auto st = new SegmentTree(M);
    long[] hoge;
    foreach (i; 0..M) hoge ~= Q[i].y;
    auto fuga = hoge.sort().uniq.array;
    int[long] comp;
    foreach (i; 0..fuga.length) comp[fuga[i.to!int]] = i.to!int;

    foreach (i; 0..M) {
        auto xxx = st.sum(0, comp[Q[i].y]) + 1;
        st.assign(comp[Q[i].y], xxx);
    }

    real ans = (x2 - x1) * 100 + (y2 - y1) * 100;
    auto xxx = st.sum(0, M-1).to!long;
    ans -= 20 * xxx;
    ans += 5 * xxx * PI;

    if (x2 - x1 + 1 == xxx || y2 - y1 + 1 == xxx) {
        ans += 5 * PI;
    } 

    writefln("%.12f", ans);
}

class SegmentTree {
    int[] table;
    int size;

    this(int n) {
        assert(bsr(n) < 29);
        size = 1 << (bsr(n) + 2);
        table = new int[](size);
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
            add(pos, num, i*2+1, left, mid);
        else
            add(pos, num, i*2+2, mid+1, right);
        table[i] = max(table[i*2+1], table[i*2+2]);
    }

    void add(int pos, int num) {
        return add(pos, num, 0, 0, size/2-1);
    }

    void add(int pos, int num, int i, int left, int right) {
        if (left == right) {
            table[i] += num;
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
