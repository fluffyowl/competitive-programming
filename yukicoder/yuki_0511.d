import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split;
    auto N = s[0].to!int;
    auto W = s[1].to!int;
    auto H = s[2].to!long;

    auto A = new int[](N);
    auto B = new long[](N);
    auto X = new int[](N);

    foreach (i; 0..N) {
        s = readln.split;
        A[i] = s[0].to!int;
        B[i] = s[1].to!long;
        X[i] = s[2].to!int - 1;
    }


    auto ans = new int[](W);
    auto rbt = new RedBlackTree!(Tuple!(int, int, int, int), "a[3] < b[3]", true)();

    foreach (i; 0..W)
        rbt.insert(tuple(i, -1, N-1, (N-2)/2));


    for (int settled = 0; settled < W; ) {
        BIT height = new BIT(W+10);

        foreach (i; 0..N) {
            height.add(X[i], X[i]+A[i], B[i]);
            auto nodes = rbt.equalRange(tuple(0, 0, 0, i)).array;

            foreach (node; nodes) {
                auto col = node[0];
                auto lo = node[1];
                auto hi = node[2];
                rbt.removeKey(node);

                if (hi - lo <= 1) {
                    settled += 1;
                    ans[col] = hi % 2 ? -1 : 1;
                } else {
                    if (height.sum(col) >= H) hi = (hi + lo) / 2;
                    else lo = (hi + lo) / 2;
                    rbt.insert(tuple(col, lo, hi, (hi+lo)/2));
                }
            }
        }
    }

    if (ans.sum > 0) writeln("A");
    else if (ans.sum == 0) writeln("DRAW");
    else writeln("B");
}


class BIT{
    int n;
    long[] table;

    this(int n){
        this.n = n;
        table = new long[](n+1);
    }

    void add(int i, long x){
        i++;
        while (i <= n){
            table[i] += x;
            i += i & -i;
        }
    }

    // [l, r)
    void add(int l, int r, long x) {
        add(l, x);
        add(r, -x);
    }

    // [0, i]
    long sum(int i){
        i++;
        long ret = 0;
        while (i > 0){
            ret += table[i];
            i -= i & -i;
        }
        return ret;
    }

    // [l, r)
    long sum(int l, int r){
        if (l >= r) return 0;
        return sum(r-1) - sum(l-1);
    }
}

