import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

const long MOD = 10^^9 + 7;
const long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    s = readln.split.map!(to!int);
    auto S = s[0] - 1;
    auto T = s[1] - 1;
    auto G = new Tuple!(int, long)[][](N);

    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        int u = s[0] - 1;
        int v = s[1] - 1;
        long d = s[2].to!long;
        G[u] ~= tuple(v, d);
        G[v] ~= tuple(u, d);
    }


    void dijkstra(int start, long[] dist) {
        dist.fill(INF);
        auto pq = new BinaryHeap!(Array!(Tuple!(int, long)), "a[1] > b[1]");
        pq.insert(tuple(start, 0L));

        while (!pq.empty) {
            auto t = pq.front;
            pq.removeFront;
            auto u = t[0];
            auto d = t[1];
            if (d >= dist[u]) continue;
            dist[u] = d;
            foreach (tt; G[u]) {
                auto v = tt[0];
                auto c = tt[1];
                if (dist[v] < d + c) continue;
                pq.insert(tuple(v, d + c));
            }
        }
    }

    auto distS = new long[](N);
    auto distT = new long[](N);
    dijkstra(S, distS);
    dijkstra(T, distT);
    auto D = distS[T];


    void dpdp(int start, long[] dp, long[] dist1, long[] dist2) {
        dp[start] = 1;
        auto pq = new BinaryHeap!(Array!(Tuple!(int, long)), "a[1] > b[1]");
        pq.insert(tuple(start, 0L));
        auto used1 = new bool[](N);
        auto used2 = new bool[](N);

        while (!pq.empty) {
            auto tt = pq.front;
            pq.removeFront;
            auto u = tt[0];
            if (used1[u]) continue;
            used1[u] = true;
            foreach (t; G[u]) {
                int v = t[0];
                long d = t[1];
                if (!used1[v] && dist1[u] + d + dist2[v] == D) {
                    dp[v] += dp[u];
                    dp[v] %= MOD;
                    if (!used2[v]) pq.insert(tuple(v, dist1[v]));
                    used2[v] = true;
                }
            }
        }
    }

    auto dpS = new long[](N);
    auto dpT = new long[](N);
    dpdp(S, dpS, distS, distT);
    dpdp(T, dpT, distT, distS);

    long ans = dpS[T] * dpS[T] % MOD;

    if (D % 2 == 0) {
        foreach (i; 0..N) {
            if (distS[i] * 2 == D) {
                ans -= dpS[i] * dpT[i] % MOD * dpS[i] % MOD * dpT[i] % MOD;
                ans %= MOD;
            }
        }
    }


    foreach (u; 0..N) {
        if (distS[u] * 2 >= D) continue;
        foreach (e; G[u]) {
            auto v = e[0];
            auto d = e[1];
            if (distS[v] * 2 <= D) continue;
            if (distS[u] + d != distS[v]) continue;
            ans -= dpS[u] * dpT[v] % MOD * dpS[u] % MOD * dpT[v] % MOD;
            ans %= MOD;
        }
    }

    ans = (ans + MOD) % MOD;
    ans.writeln;
}
