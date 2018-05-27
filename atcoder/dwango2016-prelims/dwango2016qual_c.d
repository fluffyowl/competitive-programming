import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable long INF = 1L << 59;
    
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto S = s[2];
    auto T = s[3];
    auto L = new int[](M);
    auto A = new int[][](M);
    auto W = new long[][](M);
    auto G = new Tuple!(int, long, int, long)[][](N);
    foreach (i; 0..M) {
        L[i] = readln.chomp.to!int;
        A[i] = readln.split.map!(to!int).array;
        W[i] = readln.split.map!(to!long).array;
        long acm1 = W[i].sum;
        long acm2 = 0;
        foreach (j; 0..L[i]-1) {
            acm2 += W[i][j];
            G[A[i][j]] ~= tuple(A[i][j+1], W[i][j], A[i].back, acm1);
            G[A[i][j+1]] ~= tuple(A[i][j], W[i][j], A[i].front, acm2);
            acm1 -= W[i][j];
        }
    }

    auto shortest = new long[](N);
    shortest.fill(INF);
    auto pq = new BinaryHeap!(Array!(Tuple!(int, long)), "a[1] > b[1]")();
    auto dist = new long[](N);

    pq.insert(tuple(T, 0L));
    while (!pq.empty) {
        auto t = pq.front;
        auto n = t[0];
        auto d = t[1];
        pq.removeFront;
        if (shortest[n] <= d) continue;
        shortest[n] = d;
        foreach (to; G[n]) {
            auto nn = to[0];
            auto nd = d + to[1];
            if (shortest[nn] <= nd) continue;
            pq.insert(tuple(nn, nd));
        }
    }


    long hi = 10L^^15;
    long lo = 0;
    
    while (hi - lo > 1) {
        long mid = (hi + lo) / 2;
        dist.fill(INF);
        pq.clear();
        pq.insert(tuple(S, 0L));
        bool ok = false;

        while (!pq.empty) {
            auto t = pq.front;
            auto n = t[0];
            auto d = t[1];
            pq.removeFront;
            if (n == T) {
                ok = true;
                break;
            }
            if (dist[n] <= d) continue;
            dist[n] = d;
            foreach (to; G[n]) {
                auto nn = to[0];
                auto nd = d + to[1];
                auto zzz = to[2];
                auto zzz_d = d + to[3];
                if (zzz_d + shortest[zzz] > mid) continue;
                if (dist[nn] <= nd) continue;
                if (nd > mid) continue;
                pq.insert(tuple(nn, nd));
            }
        }

        if (ok) hi = mid;
        else lo = mid;

    }
    
    hi.writeln;
}
