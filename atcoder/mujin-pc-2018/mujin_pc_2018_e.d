import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long INF = 1L << 59;
const int[] dr = [-1, 1, 0, 0];
const int[] dc = [0, 0, -1, 1]; // U, D, L, R

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto K = s[2];
    auto D = readln.chomp;
    auto A = H.iota.map!(_ => readln.chomp).array;
    auto B = new long[][](H, W);
    foreach (i; 0..H) fill(B[i], INF);

    auto next = new int[][](K, 4);
    foreach (i; 0..K) fill(next[i], -1);
    int[] tmp = [-1, -1, -1, -1];

    foreach_reverse (ii; 0..K+K) {
        int i = ii % K;
        if (D[i] == 'U') tmp[0] = i;
        if (D[i] == 'D') tmp[1] = i;
        if (D[i] == 'L') tmp[2] = i;
        if (D[i] == 'R') tmp[3] = i;
        foreach (k; 0..4) if (tmp[k] != -1) next[i][k] = tmp[k];
    }

    int sr, sc, gr, gc;
    foreach (i; 0..H) {
        foreach (j; 0..W) {
            if (A[i][j] == 'S') sr = i, sc = j;
            if (A[i][j] == 'G') gr = i, gc = j;
        }
    }

    auto pq = new BinaryHeap!(Array!(Tuple!(int, int, long)), "a[2] > b[2]");
    pq.insert(tuple(sr, sc, 0L));

    while (!pq.empty()) {
        auto t = pq.front;
        int r = t[0];
        int c = t[1];
        long d = t[2];
        int dd = d % K;
        pq.removeFront;
        if (d >= B[r][c]) continue;
        B[r][c] = d;
        foreach (k; 0..4) {
            if (next[dd][k] == -1) continue;
            int nr = r + dr[k];
            int nc = c + dc[k];
            if (nr < 0 || nr >= H || nc < 0 || nc >= W) continue;
            if (A[nr][nc] == '#') continue;
            long ndd = next[dd][k] - dd;
            if (ndd < 0) ndd += K;
            long nd = d + ndd + 1;
            if (nd >= B[nr][nc]) continue;
            pq.insert(tuple(nr, nc, nd));
        }
    }

    writeln((B[gr][gc] >= INF) ? -1 : B[gr][gc]);
}
