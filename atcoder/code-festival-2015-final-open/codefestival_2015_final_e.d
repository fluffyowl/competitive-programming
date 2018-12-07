import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable int MAX = 10^^5+10;

int pack(const int[] arr) {
    int mask = 0;
    foreach (a; arr) {
        mask *= 5;
        mask += a + 2;
    }
    return mask;
}

int[] unpack(int mask) {
    auto arr = new int[](5);
    foreach_reverse (i; 0..5) {
        arr[i] = mask % 5 - 2;
        mask /= 5;
    }
    return arr;
}

int f(int mask) {
    return mask.unpack.map!(i => i == 0 ? 1 : 0).array.pack;
}

int g(int mask) {
    return mask.unpack.map!(i => -i).array.pack;
}


void main() {
    auto S = readln.chomp;
    auto A = pack([-2, -1, 0, 1, 2]);

    foreach_reverse (c; S) {
        if (c == '!') {
            A = f(A);
        } else {
            A = g(A);
        }
    }

    auto prev_n = new int[](5^^5);
    auto prev_c = new char[](5^^5);
    auto dp = new int[](5^^5);
    fill(dp, 1 << 29);

    auto pq = new BinaryHeap!(Array!(Tuple!(int, int, int, char)), "a[1] > b[1]")();
    pq.insert(tuple(pack([-2, -1, 0, 1, 2]), 0, -1, '*'));

    while (!pq.empty) {
        int mask = pq.front[0];
        int dist = pq.front[1];
        int pn = pq.front[2];
        char pc = pq.front[3];
        pq.removeFront;
        if (dist >= dp[mask]) continue;
        dp[mask] = dist;
        prev_n[mask] = pn;
        prev_c[mask] = pc;

        int fmask = f(mask);
        int gmask = g(mask);
        if (dist + 1 < dp[fmask]) {
            pq.insert(tuple(fmask, dist + 1, mask, '!'));
        }
        if (dist + 1 < dp[gmask]) {
            pq.insert(tuple(gmask, dist + 1, mask, '-'));
        }
    }

    string ans = "";
    for (int p = A; prev_c[p] != '*'; p = prev_n[p]) {
        ans ~= prev_c[p];
    }
    ans.to!(dchar[]).reverse;

    ans.writeln;
}
