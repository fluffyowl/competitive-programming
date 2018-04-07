import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;
immutable int INF = 1 << 29;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.chomp).array;
    auto dr = [0, 0, 1, -1];
    auto dc = [1, -1, 0, 0];
    int sr, sc, gr, gc, cr, cc;

    foreach (r; 0..H) {
        foreach (c; 0..W) {
            if (A[r][c] == 'S') sr = r, sc = c;
            if (A[r][c] == 'G') gr = r, gc = c;
            if (A[r][c] == 'C') cr = r, cc = c;
        }
    }


    void dijkstra(int Sr, int Sc, int[][] dist) {
        foreach (i; 0..H) dist[i].fill(INF);
        auto pq = new BinaryHeap!(Array!(Tuple!(int, int, int)), "a[2] > b[2]");
        pq.insert(tuple(Sr, Sc, 0));
        while (!pq.empty) {
            auto t = pq.front;
            pq.removeFront;
            auto r = t[0];
            auto c = t[1];
            auto d = t[2];
            if (dist[r][c] <= d) continue;
            dist[r][c] = d;
            foreach (i; 0..4) {
                auto nr = r + dr[i];
                auto nc = c + dc[i];
                if (nr >= 0 && nr < H && nc >= 0 && nc < W && A[nr][nc] != '#' && dist[nr][nc] > d + 1) {
                    pq.insert(tuple(nr, nc, d + 1));
                }
            }
        }
    }

    auto d1 = new int[][](H, W);
    auto d2 = new int[][](H, W);
    dijkstra(sr, sc, d1);
    dijkstra(cr, cc, d2);
    auto ans = d1[cr][cc] + d2[gr][gc];
    writeln(ans >= INF ? -1 : ans);
}
