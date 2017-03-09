import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;

immutable int INF = 1 << 30;

class SegmentTree {
    int[] table;
    int N, table_size;

    this(int n) {
        N = n;
        table_size = 1;
        while (table_size < n) table_size *= 2;
        table_size *= 2;
        table = new int[](table_size);
        fill(table, -1);
    }

    void update(int pos, int num) {
        update_rec(0, 0, table_size/2-1, pos, num);
    }

    int update_rec(int i, int left, int right, int pos, int num) {
        if (left == right) {
            return table[i] = num;
        }
        auto mid = (left + right) / 2;
        if (pos <= mid) {
            int val = update_rec(i*2+1, left, mid, pos, num);
            return table[i] = min(val, table[i*2+2]);
        }
        else {
            int val = update_rec(i*2+2, mid+1, right, pos, num);
            return table[i] = min(table[i*2+1], val);
        }
    }

    int getmin(int pl, int pr) {
        return getmin_rec(0, pl, pr, 0, table_size/2-1);
    }

    int getmin_rec(int i, int pl, int pr, int left, int right) {
        if (pl > right || pr < left)
            return INF;
        else if (pl <= left && right <= pr)
            return table[i];
        else
            return min(getmin_rec(i*2+1, pl, pr, left, (left+right)/2),
                       getmin_rec(i*2+2, pl, pr, (left+right)/2+1, right));
    }

    int search_grundy(int n) {
        return search_grundy_rec(0, 0, table_size/2-1, n);
    }

    int search_grundy_rec(int i, int left, int right, int n) {
        if (left == right) return left;
        if (table[i*2+1] < n)
            return search_grundy_rec(i*2+1, left, (left+right)/2, n);
        else
            return search_grundy_rec(i*2+2, (left+right)/2+1, right, n);
    }
}


void main() {
    auto N = readln.chomp.to!int;
    auto st = new SegmentTree(N);
    st.update(0, 0);

    int ans = 0;
    foreach (i; 1..N) {
        auto s = readln.split.map!(to!int);
        auto c = s[0];
        auto a = s[1] % 2;
        auto grundy = st.search_grundy(i - c);
        st.update(grundy, i);
        ans ^= grundy * a;
        //writeln(i, " ", i - c, " ", grundy, " ", a, " ", ans);
    }

    writeln(ans ? "First" : "Second");
}
