import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    auto sa = new SuffixArray(S);
    auto lcp = sa.build_LCP;
    auto st = new SegmentTree(N);
    foreach (i; 0..N) st.assign(i, lcp[i+1]);

    bool comp(int i, int j) {
        if (i == j) return false;
        if (i > j) return !comp(j, i);
        int orig_i = i;
        int orig_j = j;
        
        int a = sa.rank[i]-1;
        int b = sa.rank[j]-1;
        int alen = N - i;
        int blen = N - j;
        int cp = st.query(min(a, b)+1, max(a, b));
        if (cp < min(alen, blen)) {
            return S[i+cp] < S[j+cp];
        }

        j = i;
        i = i + cp;
        a = sa.rank[i]-1;
        b = sa.rank[j]-1;
        alen = N - i;
        blen = N - j;
        cp = st.query(min(a, b)+1, max(a, b));
        if (cp < min(alen, blen)) {
            return S[i+cp] < S[j+cp];
        }

        i = orig_j;
        j = j + cp;
        a = sa.rank[i]-1;
        b = sa.rank[j]-1;
        alen = N - i;
        blen = N - j;
        cp = st.query(min(a, b)+1, max(a, b));
        if (cp < min(alen, blen)) {
            return S[i+cp] < S[j+cp];
        }

        return false;
    }

    N.iota.array.sort!((a, b) => comp(a, b)).map!(i => i+1).each!writeln;
}

class SuffixArray {
    string S;
    int n, k;
    int[] rank;
    int[] tmp;
    int[] sa;

    this (string S) {
        this.S = S;
        n = S.length.to!int;
        rank = new int[](n+1);
        tmp = new int[](n+1);
        sa = new int[](n+1);

        foreach (i; 0..n+1) {
            sa[i] = i;
            rank[i] = i < n ? S[i] : -1;
        }

        for (k = 1; k <= n; k *= 2) {
            sa.sort!((x, y) => compare_sa(x, y))();

            tmp[sa[0]] = 0;
            foreach (i; 1..n+1) {
                tmp[sa[i]] = tmp[sa[i-1]] + (compare_sa(sa[i-1], sa[i]) ? 1 : 0);
            }
            foreach (i; 0..n+1) {
                rank[i] = tmp[i];
            }
        }
    }

    bool compare_sa(int i, int j) {
        if (rank[i] != rank[j]) return rank[i] < rank[j];
        else {
            int ri = i + k <= n ? rank[i+k] : -1;
            int rj = j + k <= n ? rank[j+k] : -1;
            return ri < rj;
        }
    }

    int[] build_LCP() {
        int h = 0;
        int[] b = new int[](n+1);
        int[] lcp = new int[](n+1);
        foreach (i; 0..n+1) b[sa[i]] = i;
        foreach (i; 0..n+1) {
            if (b[i]){
                for (int j = sa[b[i]-1]; j+h<n && i+h<n && S[j+h] == S[i+h]; ++h) {}
                lcp[b[i]] = h;
            } else lcp[b[i]] = -1;
            if (h > 0) --h;
        }
        return lcp;        
    }
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
            assign(pos, num, i*2+1, left, mid);
        else
            assign(pos, num, i*2+2, mid+1, right);
        table[i] = min(table[i*2+1], table[i*2+2]);
    }

    int query(int pl, int pr) {
        return query(pl, pr, 0, 0, size/2-1);
    }

    int query(int pl, int pr, int i, int left, int right) {
        if (pl > right || pr < left)
            return 1<<29;
        else if (pl <= left && right <= pr)
            return table[i];
        else
            return
                min(query(pl, pr, i*2+1, left, (left+right)/2),
                    query(pl, pr, i*2+2, (left+right)/2+1, right));
    }
}
