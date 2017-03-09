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
            return sum_rec(i*2+1, pl, pr, left, (left+right)/2) +
                sum_rec(i*2+2, pl, pr, (left+right)/2+1, right);
    }
}


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    auto B = readln.split.map!(to!int).array;
    //A.map!(x => x.to!string).join(" ").writeln;
    //B.map!(x => x.to!string).join(" ").writeln;
    int[int] perm;
    int[int] rev;
    foreach (i; 0..N) {
        perm[A[i]] = i+1;
        rev[i+1] = A[i];
        A[i] = i+1;
    }
    foreach (i; 0..N) {
        B[i] = perm[B[i]];
    }

    auto st = new SegmentTree(N+1);
    long target = 0;
    foreach (b; B) {
        target += st.sum(b+1, N);
        st.add(b, 1);
    }

    if (target % 2 == 1) {
        writeln(-1);
        return;
    }


    int last; 
    target /= 2;
    st = new SegmentTree(N+1);
    auto C = B.dup;

    foreach (i; 0..N) {
        auto t = st.sum(B[i]+1, N);
        if (t > target) {
            last = i;
            break;
        }
        target -= t;
        st.add(B[i], 1);
    }

    C[0..last] = B[0..last].sort().array;
    //C.map!(x => rev[x].to!string).join(" ").writeln;
    foreach (i; 0..N) {
        foreach (j; i..N-1) {
            if (target == 0) break;
            if (C[j] > C[j+1]) {
                swap(C[j], C[j+1]);
                target -= 1;
            }
        }
    }

    C.map!(x => rev[x].to!string).join(" ").writeln;
}
