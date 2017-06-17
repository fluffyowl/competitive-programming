import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto s = readln.split;
    auto N = s[0].to!int;
    auto K = s[1].to!long;
    auto A = N.iota.map!(_ => readln.chomp.to!long - K).array;

    
    auto B = new long[](N+1);
    B[0] = 0;
    foreach (i; 0..N) B[i+1] = B[i] + A[i];
    auto C = B.dup.sort().uniq;

    
    int[long] comp;
    foreach (i, c; C.enumerate) comp[c] = i.to!int;

    
    auto st = new SegmentTree(N+1);
    long ans = 0;

    foreach (i; 0..N+1) {
        ans += st.sum(0, comp[B[i]]);
        st.add(comp[B[i]], 1);
    }


    ans.writeln;
}


class SegmentTree {
    int[] table;
    int size;

    this(int n) {
        assert(bsr(n) < 29);
        size = 1 << (bsr(n) + 2);
        table = new int[](size);
    }

    void add(int pos, int num) {
        return add(pos, num, 0, 0, size/2-1);
    }

    void add(int pos, int num, int i, int left, int right) {
        table[i] += num;
        if (left == right)
            return;
        auto mid = (left + right) / 2;
        if (pos <= mid)
            add(pos, num, i*2+1, left, mid);
        else
            add(pos, num, i*2+2, mid+1, right);
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
                sum(pl, pr, i*2+1, left, (left+right)/2) +
                sum(pl, pr, i*2+2, (left+right)/2+1, right);
    }
}
