import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


class SegmentTree {
    int[] table;
    int N, table_size;
    
    this(int n) {
        N = n;
        table_size = 1;
        while (table_size < n) table_size *= 2;
        table_size *= 2;
        table = new int[](table_size);
    }

    void add(int pos, int num) {
        add_rec(0, 0, table_size/2-1, pos, num);
    }

    void add_rec(int i, int left, int right, int pos, int num) {
        table[i] += num;
        if (left == right)
            return;
        auto mid = (left + right) / 2;
        if (pos <= mid)
            add_rec(i*2+1, left, mid, pos, num);
        else
            add_rec(i*2+2, mid+1, right, pos, num);
    }

    int sum(int pl, int pr) {
        return sum_rec(0, pl, pr, 0, table_size/2-1);
    }
    
    int sum_rec(int i, int pl, int pr, int left, int right) {
        if (pl > right || pr < left)
            return 0;
        else if (pl <= left && right <= pr)
            return table[i];
        else
            return
                sum_rec(i*2+1, pl, pr, left, (left+right)/2) +
                sum_rec(i*2+2, pl, pr, (left+right)/2+1, right);
    }
}

void main() {
    alias Tuple!(int, "l", int, "r") Seg;
    
    int N, M;
    scanf("%d %d", &N, &M);
    int l, r;
    auto segs = new Seg[][](M+1);
    foreach (i; 0..N) {
        scanf("%d %d", &l, &r);
        segs[r-l+1] ~= Seg(l, r);
    }

    
    auto st = new SegmentTree(M+2);

    foreach (d; 1..M+1) {
        foreach (s; segs[d-1]) {
            N -= 1;
            st.add(s.l, 1);
            st.add(s.r+1, -1);
        }
        
        int ans = N;
        for (int i = d; i <= M; i += d) {
            ans += st.sum(0, i);
        }
        ans.writeln;
        //writeln(d, " ", ans, " ", N);
    }


}
