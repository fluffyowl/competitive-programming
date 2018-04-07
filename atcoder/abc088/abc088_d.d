import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;
immutable long INF = 1L << 59;
int[4] dr = [0, 0, 1, -1];
int[4] dc = [1, -1, 0, 0];

void main() {
    auto s = readln.split.map!(to!int).array;
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.chomp).array;

    auto q = new DList!(Tuple!(int, int, int));
    q.insertBack(tuple(0, 0, 0));
    auto used = new bool[][](H, W);
    int ans = 1 << 29;

    int cnt = 0;
    foreach (i; 0..H) foreach (j; 0..W) cnt += A[i][j] == '#';

    while (!q.empty) {
        auto t = q.front;
        q.removeFront;
        int r = t[0];
        int c = t[1];
        int d = t[2];
        if (r == H-1 && c == W-1) {
            ans = d;
            break;
        }
        if (used[r][c]) continue;
        used[r][c] = true;
        foreach (i; 0..4) {
            int nr = r + dr[i];
            int nc = c + dc[i];
            if (nr < 0 || nr >= H || nc < 0 || nc >= W || A[nr][nc] == '#' || used[nr][nc]) continue;
            q.insertBack(tuple(nr, nc, d+1));
        }
    }

    if (ans >= 1 << 29) {
        writeln(-1);
    } else {
        writeln(H * W - cnt - ans - 1);
    }
}
