import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

int[4] dr = [-1, 1, 0, 0];
int[4] dc = [0, 0, -1, 1];

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto B = H.iota.map!(_ => readln.chomp).array;

    int sr, sc, cr, cc, gr, gc;
    foreach (i; 0..H) foreach (j; 0..W) if (B[i][j] == 'S') sr = i, sc = j;
    foreach (i; 0..H) foreach (j; 0..W) if (B[i][j] == 'C') cr = i, cc = j;
    foreach (i; 0..H) foreach (j; 0..W) if (B[i][j] == 'G') gr = i, gc = j;

    int bfs(int SR, int SC, int GR, int GC) {
        auto used = new bool[][](H, W);
        DList!(Tuple!(int, int, int)) queue;
        queue.insertBack(tuple(SR, SC, 0));
        while (!queue.empty) {
            auto t = queue.front;
            queue.removeFront;
            int r = t[0];
            int c = t[1];
            int d = t[2];
            if (r == GR && c == GC) return d;
            if (used[r][c]) continue;
            used[r][c] = true;
            foreach (i; 0..4) {
                int nr = r + dr[i];
                int nc = c + dc[i];
                int nd = d + 1;
                if (nr < 0 || nr >= H || nc < 0 || nc >= W) continue;
                if (B[nr][nc] == '#' || used[nr][nc]) continue;
                queue.insertBack(tuple(nr, nc, nd));
            }
        }

        return 1 << 29;
    }

    int ans1 = bfs(sr, sc, cr, cc);
    int ans2 = bfs(cr, cc, gr, gc);
    writeln((ans1 == 1 << 29 || ans2 == 1 << 29) ? -1 : ans1 + ans2);
}
