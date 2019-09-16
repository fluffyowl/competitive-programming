import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

const int[][] dr = [[-2, -2, -1, -1, 1, 1, 2, 2], [-1, -1, 1, 1]];
const int[][] dc = [[-1, 1, -2, 2, -2, 2, -1, 1], [-1, 1, -1, 1]];

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.chomp).array;

    int sr, sc, gr, gc;

    foreach (i; 0..H) {
        foreach (j; 0..W) {
            if (A[i][j] == 'S') {
                sr = i;
                sc = j;
            } else if (A[i][j] == 'G') {
                gr = i;
                gc = j;
            }
        }
    }


    auto dist = new int[][][](2, H, W);
    foreach (i; 0..2) foreach (j; 0..H) dist[i][j][] = 1 << 29;

    auto pq = new BinaryHeap!(Array!(Tuple!(int, int, int, int)), "a[3] > b[3]");
    pq.insert(tuple(0, sr, sc, 0));

    while (!pq.empty) {
        int k = pq.front[0];
        int r = pq.front[1];
        int c = pq.front[2];
        int d = pq.front[3];
        pq.removeFront;
        if (dist[k][r][c] <= d) continue;
        dist[k][r][c] = d;

        foreach (i; 0..dr[k].length) {
            int nr = r + dr[k][i];
            int nc = c + dc[k][i];
            if (nr < 0 || nr >= H || nc < 0 || nc >= W) continue;
            int nk = A[nr][nc] == 'R' ? k ^ 1 : k;
            int nd = d + 1;
            if (dist[nk][nr][nc] <= nd) continue;
            pq.insert(tuple(nk, nr, nc, nd));
        }
    }

    int ans = min(dist[0][gr][gc], dist[1][gr][gc]);
    writeln(ans == 1 << 29 ? -1 : ans);
}

