import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    auto B = A.dup.sort().uniq.array;

    int[int] compressor;
    foreach (i, e; enumerate(B)) {
        compressor[e] = i.to!int;
    }
    foreach (i; 0..N) {
        A[i] = compressor[A[i]];
    }
    auto M = B.length.to!int - 1;

    auto st_left = new SegmentTree(M+1);
    auto st_right = new SegmentTree(M+1);
    auto st_same = new SegmentTree(M+1);
    auto st_ans = new SegmentTree(M+1);

    foreach (i; 1..N) {
        st_right.add(A[i], 1);
    }

    foreach (i; 1..N-1) {
        st_right.add(A[i], -1);
        st_left.add(A[i-1], 1);
        auto same = st_same.sum(A[i-1], A[i-1]);
        st_same.add(A[i-1], -same);
        st_same.add(A[i-1], st_left.sum(A[i-1], A[i-1]) * st_right.sum(A[i-1], A[i-1]));
        
        long ans = 0;
        if (A[i] > 0) {
            ans += st_left.sum(0, A[i]-1) * st_right.sum(0, A[i]-1) - st_same.sum(0, A[i]-1);
        }
        if (A[i] < M) {
            ans += st_left.sum(A[i]+1, M) * st_right.sum(A[i]+1, M) - st_same.sum(A[i]+1, M);
        }
        st_ans.add(A[i], ans);
    }
    
    auto Q = readln.chomp.to!int;
    foreach (q; 0..Q) {
        auto s = readln.split.map!(to!int);
        auto L = s[0];
        auto R = s[1];

        int hi, lo;
        hi = M+1;
        lo = -1;
        while (hi - lo > 1) {
            int mid = (hi + lo) / 2;
            if (B[mid] >= L) hi = mid;
            else lo = mid;
        }
        L = hi;
        
        hi = M+1;
        lo = -1;
        while (hi - lo > 1) {
            int mid = (hi + lo) / 2;
            if (B[mid] <= R) lo = mid;
            else hi = mid;
        }
        R = lo;

        if (L > M || R < 0) {
            0.writeln;
            continue;
        }
        L = max(0, L);
        R = min(M, R);
        st_ans.sum(L, R).writeln;
    }

}

class SegmentTree {
    long[] table;
    int size;

    this(int n) {
        assert(bsr(n) < 29);
        size = 1 << (bsr(n) + 2);
        table = new long[](size);
        fill(table, 0);
    }

    void add(int pos, long num) {
        return add(pos, num, 0, 0, size/2-1);
    }

    void add(int pos, long num, int i, int left, int right) {
        table[i] += num;
        if (left == right)
            return;
        auto mid = (left + right) / 2;
        if (pos <= mid)
            add(pos, num, i*2+1, left, mid);
        else
            add(pos, num, i*2+2, mid+1, right);
    }

    long sum(int pl, int pr) {
        return sum(pl, pr, 0, 0, size/2-1);
    }

    long sum(int pl, int pr, int i, int left, int right) {
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

