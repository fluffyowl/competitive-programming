import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

alias Tuple!(int, "r", int, "c", int, "d", int, "cost") Node;
int[] dr = [0, 0, -1, 1];
int[] dc = [-1, 1, 0, 0];


void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto K = s[2];
    auto B = H.iota.map!(_ => readln.chomp).array;
    int sr, sc;
    foreach (i; 0..H) foreach (j; 0..W) if (B[i][j] == 'S') sr = i, sc = j;

    bool is_goal(Node n) {
        return (n.r == 0 || n.r == H-1 || n.c == 0 || n.c == W-1);
    }

    auto used = new bool[][](H, W);
    DList!Node queue;
    queue.insertBack(Node(sr, sc, 0, 1));
    while (!queue.empty) {
        auto n = queue.front;
        queue.removeFront;
        auto r = n.r;
        auto c = n.c;
        auto d = n.d;
        auto cost = n.cost;

        if (is_goal(n)) {
            writeln(1);
            return;
        }

        if (used[r][c]) continue;
        used[r][c] = true;
        if (d == K) continue;

        foreach (i; 0..4) {
            int nr = r + dr[i];
            int nc = c + dc[i];
            if (nr < 0 || nr >= H || nc < 0 || nc >= W || B[nr][nc] == '#') continue;
            queue.insert(Node(nr, nc, d+1, cost));
        }
    }


    int ans = 1 << 29;
    foreach (i; 0..H) {
        foreach (j; 0..W) {
            if (!used[i][j]) continue;
            ans = min(ans, (i-1)/K + 2);
            ans = min(ans, (H-1-i-1)/K + 2);
            ans = min(ans, (j-1)/K + 2);
            ans = min(ans, (W-1-j-1)/K + 2);
        }
    }

    ans.writeln;
}
