import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto A = readln.split.map!(to!long).array;

    if (N == 1 || K == 1) {
        writeln(0);
        return;
    }

    auto rbt_small = new RedBlackTree!(long, "a < b", true)();
    auto rbt_large = new RedBlackTree!(long, "a < b", true)();
    rbt_small.insert(-INF);
    rbt_large.insert(INF);

    long sum_small = 0;
    long sum_large = 0;
    long ans = INF;

    foreach (i; 0..N) {
        if (i >= K) {
            if (!rbt_small.equalRange(A[i-K]).empty) {
                rbt_small.removeKey(A[i-K]);
                sum_small -= A[i-K];
            } else {
                rbt_large.removeKey(A[i-K]);
                sum_large -= A[i-K];
            }
        }
        rbt_small.insert(A[i]);
        sum_small += A[i];
        while (rbt_small.back > rbt_large.front) {
            auto x = rbt_small.back;
            rbt_small.removeKey(x);
            rbt_large.insert(x);
            sum_small -= x;
            sum_large += x;
        }
        while (rbt_small.length >= rbt_large.length + 2) {
            auto x = rbt_small.back;
            rbt_small.removeKey(x);
            rbt_large.insert(x);
            sum_small -= x;
            sum_large += x;
        }
        while (rbt_large.length >= rbt_small.length + 2) {
            auto x = rbt_large.front;
            rbt_large.removeKey(x);
            rbt_small.insert(x);
            sum_small += x;
            sum_large -= x;
        }

        if (i < K - 1) {
            continue;
        }

        long a = rbt_small.length.to!long;
        long b = rbt_large.length.to!long;
        long mid1, mid2 = -1;

        if (K % 2 && rbt_small.length > rbt_large.length) {
            mid1 = rbt_small.back;
        } else if (K % 2 && rbt_large.length > rbt_small.length) {
            mid2 = rbt_large.front;
        } else {
            mid1 = (rbt_small.back + rbt_large.front) / 2;
            if ((rbt_small.back + rbt_large.front) % 2) {
                mid2 = mid1 + 1;
            }
        }

        ans = min(ans, mid1 * a - sum_small + sum_large - mid1 * b);
        if (mid2 >= 0) {
            ans = min(ans, mid2 * a - sum_small + sum_large - mid2 * b);
        }
    }

    ans.writeln;
}

