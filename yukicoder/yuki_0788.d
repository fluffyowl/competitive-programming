import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto K = s[2] - 1;
    auto T = readln.split.map!(to!long).array;
    auto G = new Tuple!(int, long)[][](N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        G[s[0]-1] ~= tuple(s[1]-1, s[2].to!long);
        G[s[1]-1] ~= tuple(s[0]-1, s[2].to!long);
    }

    long ans = 1L << 59;
    auto dist = new long[](N);
    auto pq = new BinaryHeap!(Array!(Tuple!(int, long)), "a[1] > b[1]");
    Tuple!(int, long)[] x;

    {
        dist[] = 1L << 59;
        pq.clear();
        pq.insert(tuple(K, 0L));
        while (!pq.empty) {
            auto n = pq.front[0];
            auto d = pq.front[1];
            pq.removeFront;
            if (dist[n] <= d) continue;
            dist[n] = d;
            foreach (e; G[n]) {
                auto m = e[0];
                auto nd = e[1] + d;
                if (dist[m] <= nd) continue;
                pq.insert(tuple(m, nd));
            }
        }

        foreach (i; 0..N) if (T[i] > 0) x ~= tuple(i, dist[i]);
        x.sort!"a[1] < b[1]";
    }

    foreach (v; 0..N) {
        dist[] = 1L << 59;
        pq.clear();
        pq.insert(tuple(v, 0L));
        while (!pq.empty) {
            auto n = pq.front[0];
            auto d = pq.front[1];
            pq.removeFront;
            if (dist[n] <= d) continue;
            dist[n] = d;
            foreach (e; G[n]) {
                auto m = e[0];
                auto nd = e[1] + d;
                if (dist[m] <= nd) continue;
                pq.insert(tuple(m, nd));
            }
        }

        long tmp = 0;
        foreach (i; 0..N) {
            tmp += T[i] * 2 * dist[i];
        }

        auto y = x.front[0];
        auto z = x.front[1];
        tmp = min(tmp, tmp - dist[y] + z);

        ans = min(ans, tmp);
    }

    ans.writeln;
}

