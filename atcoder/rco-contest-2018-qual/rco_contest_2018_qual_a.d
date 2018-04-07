import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto H = s[2];
    auto W = s[3];
    auto T = s[4];
    auto maps = N.iota.map!(_ => H.iota.map!(_ => readln.chomp.to!(dchar[])).array).array;

    auto sr = new int[](N);
    auto sc = new int[](N);
    auto dr = [-1, 1, 0, 0];
    auto dc = [0, 0, -1, 1];
    auto dir = "UDLR";

    foreach (i; 0..N) {
        foreach (r; 0..H) {
            foreach (c; 0..W) {
                if (maps[i][r][c] == '@') {
                    sr[i] = r;
                    sc[i] = c;
                    break;
                }
            }
        }
    }

    int simulate(int map_number, int[] command) {
        int ans = 0;
        int r = sr[map_number];
        int c = sc[map_number];
        auto map = maps[map_number];

        foreach (com; command) {
            int nr, nc;
            nr = r + dr[com];
            nc = c + dc[com];
            if (map[nr][nc] == '#') continue;
            if (map[nr][nc] == 'x') return ans;
            if (map[nr][nc] == 'o') {ans += 1; map[nr][nc] = '@';}
            r = nr;
            c = nc;
        }

        return ans;
    }

    Tuple!(int, int)[] simulate_all(int[] command) {
        auto sims = N.iota.map!(i => tuple(simulate(i, command), i)).array;
        sims.sort!"a[0] > b[0]";
        return sims;
    }

    int eval(Tuple!(int, int)[] sims) {
        return sims[0..K].map!(s => s[0]).sum;
    }

    int[] search(int m1, int[] M) {
        int N = M.length.to!int;
        auto map = new dchar[][](H, W);
        auto map2 = new dchar[][][](N, H, W);
        foreach (i; 0..H) foreach (j; 0..W) map[i][j] = maps[m1][i][j];
        foreach (k; 0..N) foreach (i; 0..H) foreach (j; 0..W) map2[k][i][j] = maps[M[k]][i][j];
        int cr = sr[m1];
        int cc = sc[m1];
        int cnt = T;
        int[] command;
        int[] cr2 = M.map!(mm => sr[mm]).array;
        int[] cc2 = M.map!(mm => sc[mm]).array;

        while (true) {
            DList!(Tuple!(int, int, int, int[], int[])) q;
            q.insertBack(tuple(cr, cc, -1, cr2.dup, cc2.dup));
            bool[int][int] used;
            int[int][int] prev;
            int gr = -1;
            int gc = -1;
            int[] gr2 = new int[](N);
            int[] gc2 = new int[](N);

            while (!q.empty) {
                auto t = q.front; q.removeFront;
                int r = t[0];
                int c = t[1];
                int pd = t[2];
                int[] r2 = t[3].dup;
                int[] c2 = t[4].dup;

                if (r in used && c in used[r]) continue;
                used[r][c] = true;
                prev[r][c] = pd;
                int[] dirs = [0, 1, 2, 3];
                dirs.randomShuffle;
                bool ok = false;

                foreach (i; dirs) {
                    int nr = r + dr[i];
                    int nc = c + dc[i];
                    int[] nr2 = new int[](N);
                    int[] nc2 = new int[](N);
                    foreach (j; 0..N) nr2[j] = r2[j] + dr[i];
                    foreach (j; 0..N) nc2[j] = c2[j] + dc[i];
                    if (map[nr][nc] == '#') continue;
                    if (map[nr][nc] == 'x') continue;
                    if (N.iota.map!(j => map2[j][nr2[j]][nc2[j]] == 'x').any) continue;
                    if (nr in used && nc in used[nr]) continue;
                    foreach (j; 0..N) if (map2[j][nr2[j]][nc2[j]] == '#') nr2[j] = r2[j], nc2[j] = c2[j];
                    if (map[nr][nc] == 'o') {
                        gr = nr;
                        gc = nc;
                        foreach (j; 0..N) gr2[j] = nr2[j], gc2[j] = nc2[j];
                        prev[gr][gc] = i;
                        ok = true;
                        map[nr][nc] = '@';
                        break;
                    }
                    q.insertBack(tuple(nr, nc, i, nr2, nc2));
                }

                if (ok) break;
            }

            if (gr == -1) break;
            int[] new_com;
            int r = gr;
            int c = gc;
            while (prev[r][c] != -1) {
                new_com ~= prev[r][c];
                int nr = r - dr[prev[r][c]];
                int nc = c - dc[prev[r][c]];
                cnt -= 1;
                if (cnt <= 0) break;
                r = nr;
                c = nc;
            }

            new_com.reverse();
            foreach (com; new_com) command ~= com;
            if (cnt <= 0) break;
            cr = gr;
            cc = gc;
            foreach (j; 0..N) cr2[j] = gr2[j];
            foreach (j; 0..N) cc2[j] = gc2[j];
        }

        return command;
    }

    int best_score = 0;
    int[] best_command;
    Tuple!(int, int)[] best_sims;

    foreach (_; 0..700) {
        int x = uniform(0, N);
        auto hoge = iota(K-5).map!(k => uniform(0, N)).array;
        auto command = search(x, hoge);
        auto sims = simulate_all(command);
        int score = eval(sims);
        if (score > best_score) {
            best_score = score;
            best_command = command;
            best_sims = sims;
        }
    }

    best_sims[0..K].map!(s => s[1].to!string).join(" ").writeln;
    best_command.map!(c => dir[c]).writeln;
}
