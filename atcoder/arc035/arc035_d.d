import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    const int MAX = 10^^6 + 1;
    auto logf = new real[](MAX);
    logf[0] = logf[1] = 0;
    foreach (i; 1..MAX-1) logf[i+1] = logf[i] + log(i+1);

    real dist(int x1, int y1, int x2, int y2) {
        int x = abs(x1 - x2);
        int y = abs(y1 - y2);
        return logf[x + y] - logf[x] - logf[y];
    }


    auto N = readln.chomp.to!int;
    auto X = new int[](N);
    auto Y = new int[](N);
    foreach (i; 0..N) {
        auto s = readln.split.map!(to!int);
        X[i] = s[0];
        Y[i] = s[1];
    }


    auto st = new SegmentTree(N-1);
    foreach (i; 0..N-1) {
        st.assign(i, dist(X[i], Y[i], X[i+1], Y[i+1]));
    }
    
    
    auto Q = readln.chomp.to!int;
    while (Q--) {
        auto s = readln.split.map!(to!int);
        if (s[0] == 1) {
            int i = s[1] - 1;
            X[i] = s[2];
            Y[i] = s[3];
            if (i < N - 1) st.assign(i, dist(X[i], Y[i], X[i+1], Y[i+1]));
            if (i > 0) st.assign(i-1, dist(X[i], Y[i], X[i-1], Y[i-1]));
        } else {
            writeln(st.sum(s[1]-1, s[2]-2) > st.sum(s[3]-1, s[4]-2) ? "FIRST" : "SECOND"); 
        }
    }

    
}


class SegmentTree {
    real[] table;
    int size;

    this(int n) {
        assert(bsr(n) < 29);
        size = 1 << (bsr(n) + 2);
        table = new real[](size);
        fill(table, 0);
    }

    void assign(int pos, real num) {
        return assign(pos, num, 0, 0, size/2-1);
    }

    void assign(int pos, real num, int i, int left, int right) {
        if (left == right) {
            table[i] = num;
            return;
        }
        auto mid = (left + right) / 2;
        if (pos <= mid)
            assign(pos, num, i*2+1, left, mid);
        else
            assign(pos, num, i*2+2, mid+1, right);
        table[i] = table[i*2+1] + table[i*2+2];
    }

    real sum(int pl, int pr) {
        return sum(pl, pr, 0, 0, size/2-1);
    }

    real sum(int pl, int pr, int i, int left, int right) {
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
