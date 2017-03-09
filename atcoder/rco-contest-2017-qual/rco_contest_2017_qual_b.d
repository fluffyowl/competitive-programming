import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;
import std.datetime;

alias Tuple!(int, "f", int, "d") Esa;
immutable int H = 50;
immutable int W = 50;
immutable int K = 2500;
immutable int INF = 1 << 30;
auto B = new string[](H);
auto esa = new Esa[][](H, W);
int[4] dr = [0, 0, 1, -1];
int[4] dc = [1, -1, 0, 0];
string dir = "DURL";
int[][] dist;
auto prev = new int[][](H, W);

int evaluate(int r, int c, ref char[] d) {
    int ans = 0;
    int turn = 0;
    auto used = new bool[][](H, W);
    foreach (ch; d) {
        int nr, nc;
        if (ch == 'U') {
            nr = r - 1;
            nc = c;
        }
        else if (ch == 'D') {
            nr = r + 1;
            nc = c;
        }
        else if (ch == 'R') {
            nr = r;
            nc = c + 1;
        }
        else if (ch == 'L') {
            nr = r;
            nc = c - 1;
        }

        if (nr < 0 || nr >= H || nc < 0 || nc >= W || B[nr][nc] == '#') {
            nr = r;
            nc = c;
        }

        r = nr;
        c = nc;
        if (!used[r][c]) {
            ans += esa[r][c].f - esa[r][c].d * turn;
        }

        used[r][c] = true;
        turn++;
    }

    return ans;
}

void dijkstra(int sr, int sc) {
    alias Tuple!(int, "r", int, "c", int, "dir", int, "d") Node;
    dist = new int[][](H, W);
    foreach (i; 0..H) fill(dist[i], 1 << 30);
    auto q = new BinaryHeap!(Array!Node, "a.d >= b.d")();

    dist[sr][sc] = 0;
    q.insert(Node(sr, sc, -1, 0));
    while(!q.empty) {
        auto fff = q.front;
        int r = fff.r;
        int c = fff.c;
        int ddd = fff.dir;
        int cost = fff.d;

        q.popFront;

        if (dist[r][c] < cost) continue;
        prev[r][c] = ddd;

        foreach(i; 0..4) {
            int nr = r + dr[i];
            int nc = c + dc[i];
            if (nr < 0 || nr >= H || nc < 0 || nc > W || B[nr][nc] == '#')
                continue;
            if (dist[r][c] + 1 < dist[nr][nc]) {
                dist[nr][nc] = dist[r][c] + 1;
                q.insert(Node(nr, nc, i, dist[nr][nc]));
            }
        }

    }
}

void main() {
    auto stattime = Clock.currTime();

    auto s = readln.split.map!(to!int);
    auto sr = s[3];
    auto sc = s[4];
    foreach (i; 0..H) {
        B[i] = readln.chomp;
    }
    auto ans = new char[](K);
    foreach (i; 0..H) fill(esa[i], Esa(0, 0));
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        s = readln.split.map!(to!int);
        esa[s[0]-1][s[1]-1] = Esa(s[2], s[3]);
    }

    dijkstra(sr, sc);
    int best_esa = 0;
    int best_i = -1;
    int best_j = -1;
    foreach (i; 0..H) {
        foreach (j; 0..W) {
            if (esa[i][j].f == 0 || dist[i][j] == (1 << 30)) continue;
            int p = esa[i][j].f - esa[i][j].d * (dist[i][j]-1);
            if (p >= best_esa) {
                best_esa = p;
                best_i = i;
                best_j = j;
            }
        }
    }

    char[] first;
    int first_len = 0;
    while (prev[best_i][best_j] != -1) {
        first = dir[prev[best_i][best_j]] ~ first;
        best_i -= dr[prev[best_i][best_j]];
        best_j -= dc[prev[best_i][best_j]];
        first_len += 1;
    }
    ans [0..first_len] = first;

    foreach (i; first_len..K) {
        ans[i] = dir[uniform(0, 4)];
    }

    int current_score = evaluate(sr, sc, ans);
    int best_score = current_score;
    int trying = 10;

    while ((Clock.currTime - stattime).total!"msecs" < dur!"msecs"(9980).total!"msecs") {
        auto origc = new char[](trying);
        auto origi = new int[](trying);
        foreach (j; 0..trying) {
            int i = uniform(first_len, K);
            while (canFind(origi, i)) {
                i = uniform(0, K);
            }
            origc[j] = ans[i];
            origi[j] = i;
            ans[i] = dir[uniform(0, 4)];
        }
        int next_score = evaluate(sr, sc, ans);
        if (next_score >= best_score) {
            best_score = next_score;
            current_score = next_score;
        }
        else {
            foreach (i; 0..trying)
                ans[origi[i]] = origc[i];
        }
    }


    ans.writeln;
}
