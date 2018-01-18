import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto Q = readln.chomp.to!int;
    
    auto queries = new Tuple!(int, long)[](Q);
    long[] nums;
    int[long] comp;
    long offset;
    
    foreach (i; 0..Q) {
        auto s = readln.split;
        auto t = s[0].to!int;
        auto x = s[1].to!long;
        queries[i] = tuple(t, x);
        if (t == 1) {
            nums ~= x-offset;
        } else if (t == 3) {
            offset += x;
        }
    }

    nums.sort();
    foreach (i, e ; nums.enumerate) {
        comp[e] = i.to!int;
    }
    
    auto st = new SegmentTree(nums.length.to!int);
    
    offset = 0;
    long[] L;

    foreach (q; queries) {
        auto t = q[0];
        auto x = q[1];
        if (t == 1) {
            L ~= x - offset;
            st.add(comp[x-offset], 1);
        } else if (t == 2) {
            st.add(comp[L[x.to!int-1]], -1);
        } else {
            offset += x;
        }

        long hi = 10L^^5+1;
        long lo = 0;

        while (hi - lo > 1) {
            auto mid = (hi + lo) / 2;
            auto lb = nums.assumeSorted.upperBound(mid-offset-1);
            auto cnt = lb.empty ? 0 : st.sum(comp[lb.front], nums.length.to!int-1);
            if (cnt >= mid) lo = mid;
            else hi = mid;
        }

        max(0, lo).writeln;
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

