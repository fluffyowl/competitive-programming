import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    auto C = readln.split;
    auto A = iota(0, N, 2).map!(i => C[i].to!long).array;
    auto B = iota(1, N, 2).map!(i => C[i]).array;

    auto st = new SegmentTree(N/2+1, B.dup);
    foreach (i; 0..N/2+1) st.update(i, A[i]);

    auto Q = readln.chomp.to!int;
    while (Q--) {
        auto q = readln.split;
        auto a = q[1].to!int - 1;
        auto b = q[2].to!int - 1;
        auto parity = a % 2;
        a /= 2;
        b /= 2;
        if (q[0] == "?") {
            st.query(a, b).writeln;
        } else if (parity) {
            if (st.ops[a] == st.ops[b]) continue;
            swap(st.ops[a], st.ops[b]);
            st.update(a, A[a]);
            st.update(a+1, A[a+1]);
            st.update(b, A[b]);
            st.update(b+1, A[b+1]);
        } else {
            if (A[a] == A[b]) continue;
            swap(A[a], A[b]);
            st.update(a, A[a]);
            st.update(b, A[b]);
        }
    }

}

class SegmentTree {
    long[][] table;
    string[] ops;
    int size;

    this(int n, string[] ops) {
        assert(bsr(n) < 29);
        size = 1 << (bsr(n) + 2);
        table = new long[][](size);
        this.ops = ops;
    }

    long[] merge(int mid, long[] a1, long[] a2) {
        long[] ret;
        if (a1 == [] || a2 == []) {
            ret = a1 ~ a2;
        } else if (ops[mid] == "+") {
            long tmp = 0;
            foreach (x; a1[1..$]) (tmp += x) %= MOD;
            foreach (x; a2[0..$-1]) (tmp += x) %= MOD;
            ret = [];
            ret ~= a1.front;
            if (tmp > 0) ret ~= tmp;
            ret ~= a2.back;
        } else {
            long tmp = a1.back * a2.front % MOD;
            if (a1.length == 1 && a2.length == 1) {
                ret = [tmp];
            } else if (a1.length == 1) {
                ret = tmp ~ a2[1..$];
            } else if (a2.length == 1) {
                ret = a1[0..$-1] ~ tmp;
            } else {
                foreach (x; a1[1..$-1]) (tmp += x) %= MOD;
                foreach (x; a2[1..$-1]) (tmp += x) %= MOD;
                ret = [a1.front, tmp, a2.back];
            }
        }
        return ret;
    }
    
    void update(int pos, long num) {
        return update(pos, num, 0, 0, size/2-1);
    }

    void update(int pos, long num, int i, int left, int right) {
        if (left == right) {
            table[i] = [num];
            return;
        }
        
        auto mid = (left + right) / 2;
        if (pos <= mid)
            update(pos, num, i*2+1, left, mid);
        else
            update(pos, num, i*2+2, mid+1, right);

        table[i] = merge(mid, table[i*2+1], table[i*2+2]);
    }

    long query(int pl, int pr) {
        auto X = query(pl, pr, 0, 0, size/2-1);
        long ret = 0;
        foreach (x; X) (ret += x) %= MOD;
        return ret;
    }

    long[] query(int pl, int pr, int i, int left, int right) {
        if (pl > right || pr < left) {
            return [];
        } else if (pl <= left && right <= pr) {
            return table[i];
        } else {
            auto a = query(pl, pr, i*2+1, left, (left+right)/2);
            auto b = query(pl, pr, i*2+2, (left+right)/2+1, right);
            auto x =  merge((left + right) / 2, a, b);
            return x;
        }
    }
}

