import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

alias Tuple!(int, "a", int, "b") Score;
const int MAX = 10^^5 + 10;

void main() {
    auto t = readln.split.map!(to!int);
    auto N = t[0];
    auto M = t[1];
    Score[] s0;
    Score[] s1;
    Score[] s2;
    int cnt2 = 0;
    int cnt3 = 0;
    foreach (i; 0..N) {
        t = readln.split.map!(to!int);
        if (t[0] == 0)
            s0 ~= Score(t[1], t[2]);
        else if (t[0] == 1)
            s1 ~= Score(t[1], t[2]);
        else if (t[0] == 2)
            s2 ~= Score(t[1], t[2]), cnt2 += 1;
        else
            cnt2 += 1, cnt3 += 1;
    }


    int ans = 1 << 29;
    s0.sort!"a[0] < b[0]";
    s1.sort!"a[0] < b[0]";
    s2.sort!"a[0] < b[0]";
    auto st0 = new BIT(MAX);
    auto st1a = new BIT(MAX);
    auto st1b = new BIT(MAX);
    auto st2 = new BIT(MAX);
    int p0 = s0.length.to!int - 1;
    int p1 = s1.length.to!int - 1;
    int p2 = s2.length.to!int - 1;

    foreach (s; s1)
        st1b.add(s.b, 1);
    foreach (s; s2)
        st2.add(s.b, 1);


    for (int a = MAX - 1; a >= 0; --a) {

        for (; p0 >= 0 && s0[p0].a == a; p0--)
            st0.add(s0[p0].b, 1);
        for (; p1 >= 0 && s1[p1].a == a; p1--) {
            st1a.add(s1[p1].b, 1);
            st1b.add(s1[p1].b, -1);
            cnt2 += 1;
        }
        for (; p2 >= 0 && s2[p2].a == a; p2--) {
            st2.add(s2[p2].b, -1);
            cnt3 += 1;
        }

        int target = M - cnt2;
        if (target <= 0) {
            ans = min(ans, cnt3);
            continue;
        }

        int hi = MAX-1;
        int lo = -1;
        while (hi - lo > 1) {
            int mid = (hi + lo) / 2;
            int tmp2 = 0;
            tmp2 += st0.sum(mid, MAX);
            tmp2 += st1b.sum(mid, MAX);
            if (tmp2 < target)
                hi = mid;
            else
                lo = mid;
        }

        if (lo == -1)
            continue;

        int tmp3 = 0;
        tmp3 += st1a.sum(lo, MAX);
        tmp3 += st2.sum(lo, MAX);
        ans = min(ans, cnt3 + tmp3);
    }

    ans.writeln;
}


class BIT{
    int n;
    int[] table;

    this(int x){
        n = x;
        table = new int[](x+1);
    }

    void add(int i, int x){
        i++;
        while (i <= n){
            table[i] += x;
            i += i & -i;
        }
    }

    // [0, i]
    int sum(int i){
        i++;
        int ret = 0;
        while (i > 0){
            ret += table[i];
            i -= i & -i;
        }
        return ret;
    }

    // [l, r)
    int sum(int l, int r){
        if (l >= r) return 0;
        return sum(r-1) - sum(l-1);
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

