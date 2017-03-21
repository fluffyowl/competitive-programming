import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


void main() {
    auto s = readln.split;
    auto N = s[0].to!int;
    auto D = s[1].to!int;
    auto K = s[2].to!long;
    auto X = N.iota.map!(_ => readln.chomp.to!int).array;

    auto st = new SegmentTree(N);
    foreach (i; 0..N) st.update(i, X[i]);

    long m = 0;
    int a;
    foreach (i; 0..N-1) {
        auto mm = st.getmax(i+1, min(N-1, i+D)) - X[i];
        if (mm > m) a = i, m = mm;

    }

    if (m <= 0)
        writeln(0);
    else {
        int b;
        foreach (i; a+1..N) {
            if (X[i] - X[a] == m) {
                b = i;
                break;
            }
        }
        writeln(m * K);
        writeln(a, " ", b);
    }
}

class SegmentTree {
    long[] table;
    int N, table_size;

    this(int n) {
        N = n;
        table_size = 1;
        while (table_size < n) table_size *= 2;
        table_size *= 2;
        table = new long[](table_size);
        fill(table, -1);
    }

    void update(int pos, long num) {
        update_rec(0, 0, table_size/2-1, pos, num);
    }

    long update_rec(int i, int left, int right, int pos, long num) {
        if (left == right) {
            table[i] = max(num, table[i]);
            return table[i];
        }
        auto mid = (left + right) / 2;
        if (pos <= mid) {
            table[i] = max(update_rec(i*2+1, left, mid, pos, num),
                           table[i*2+2]);
        }
        else {
            table[i] = max(table[i*2+1],
                           update_rec(i*2+2, mid+1, right, pos, num));
        }
        return table[i];
    }

    long getmax(int pl, int pr) {
        return getmax_rec(0, pl, pr, 0, table_size/2-1);
    }

    long getmax_rec(int i, int pl, int pr, int left, int right) {
        if (pl > right || pr < left)
            return -1;
        else if (pl <= left && right <= pr)
            return table[i];
        else
            return max(getmax_rec(i*2+1, pl, pr, left, (left+right)/2),
                       getmax_rec(i*2+2, pl, pr, (left+right)/2+1, right));
    }
}

