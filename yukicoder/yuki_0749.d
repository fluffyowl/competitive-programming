import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable long INF = 1L<<59;
immutable long MOD = 10^^9+7;

long[] F, G;

alias T = long;
alias L = Tuple!(long, "a", long, "b", long, "c");
immutable T eT = 0L;
immutable L eL = L(1L, 0L, 0L);

pragma(inline);
T opTT(T t1, T t2) {
    return (t1 + t2) % MOD;
}

T opTL(T t, L l) {
    return (t * l.a % MOD + l.b + l.c) % MOD;
}

L opLL(L l1, L l2) {
    return L(l1.a * l2.a % MOD, (l1.b * l2.a % MOD + l2.b) % MOD, (l1.c * l2.a % MOD + l2.c) % MOD);
}

L opPrd(L l, int a, int b) {
    return L(l.a, l.b * (b - a + 1) % MOD, (G[b+1] - G[a]) * l.c % MOD);
}

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto Q = s[1];

    F = new long[](N);
    G = new long[](N+1);
    F[0] = 0;
    F[1] = 1;
    foreach (i; 2..N) F[i] = (F[i-1] + F[i-2]) % MOD;
    foreach (i; 0..N) G[i+1] = (G[i] + F[i]) % MOD;

    auto st = new LazySegmentTree!(T, L, opTT, opTL, opLL, opPrd, eT, eL)(N);


    while (Q--) {
        s = readln.split.map!(to!int);
        auto q = s[0];
        auto l = s[1];
        auto r = s[2];
        auto k = s[3].to!long;

        if (q == 0) {
            auto v = st.query(l, r);
            v = (v % MOD * k % MOD + MOD) % MOD;
            v.writeln;
        } else if (q == 1) {
            st.update(l, r, L(0L, k, 0L));
        } else if (q == 2) {
            st.update(l, r, L(1L, k, 0L));
        } else if (q == 3) {
            st.update(l, r, L(k, 0L, 0L));
        } else {
            st.update(l, r, L(1L, 0L, k));
        }
    }
}



class LazySegmentTree(T, L, alias opTT, alias opTL, alias opLL, alias opPrd, T eT, L eL) {
    pragma(inline);
    T[] table;
    L[] lazy_;
    int n;
    int size;

    this(int n) {
        this.n = n;
        size = 1;
        while (size <= n) size <<= 1;
        size <<= 1;
        table = new T[](size);
        lazy_ = new L[](size);
        table[] = eT;
        lazy_[] = eL;
    }

    void push(int i, int a, int b) {
        if (lazy_[i] == eL) return;
        table[i] = opTL(table[i], opPrd(lazy_[i], a, b));
        if (i * 2 + 1 < size) {
            lazy_[i*2] = opLL(lazy_[i*2], lazy_[i]);
            lazy_[i*2+1] = opLL(lazy_[i*2+1], lazy_[i]);
        }
        lazy_[i] = eL;
    }

    T query(int l, int r) {
        if (l > r) return eT;
        return query(l, r, 1, 0, n-1);
    }

    T query(int l, int r, int i, int a, int b) {
        if (b < l || r < a) return eT;
        push(i, a, b);
        if (l <= a && b <= r) {
            return table[i];
        } else {
            return opTT(query(l, r, i*2, a, (a+b)/2), query(l, r, i*2+1, (a+b)/2+1, b));
        }
    }

    void update(int l, int r, L val) {
        if (l > r) return;
        update(l, r, 1, 0, n-1, val);
    }

    void update(int l, int r, int i, int a, int b, L val) {
        if (b < l || r < a) {
            push(i, a, b);
        } else if (l <= a && b <= r) {
            lazy_[i] = opLL(lazy_[i], val);
            push(i, a, b);
        } else {
            push(i, a, b);
            update(l, r, i*2, a, (a+b)/2, val);
            update(l, r, i*2+1, (a+b)/2+1, b, val);
            table[i] = opTT(table[i*2], table[i*2+1]);
        }
    }
}

