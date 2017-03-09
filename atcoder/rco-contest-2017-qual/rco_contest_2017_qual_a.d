import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;
import std.datetime;


immutable int H = 50;
immutable int W = 50;
immutable int K = 8;
auto board = new int[H][W];
auto group = new int[H][W];
auto group_len = new int[H*W];
auto stack = new int[H*W];
int[4] dr = [0, 0, 1, -1];
int[4] dc = [1, -1, 0, 0];
alias Tuple!(int, "r", int, "c", int, "p") Node;
auto groups = new Node[][](0);


void dump() {
    writeln(groups.length);
    foreach (gg; groups) {
        foreach (g; gg) {
            writeln(g[0]+1, " ", g[1]+1);
        }
    }
}

void main() {
    auto stattime = Clock.currTime();
    readln;

    auto qqq = new Tuple!(int, int, int)[](0);
    foreach (i; 0..H) {
        auto s = readln.chomp;
        foreach (j; 0..W) {
            board[i][j] = s[j].to!string.to!int;
            qqq ~= tuple(i, j, board[i][j]);
        }
    }

    qqq.sort!"a[2] > b[2]";
    auto used = new bool[][](H, W);

    foreach (q; qqq) {
        auto r = q[0];
        auto c = q[1];
        if (used[r][c] || board[r][c] == 0) continue;
        auto queue = new BinaryHeap!(Array!Node, "a.p < b.p")();
        queue.insert(Node(r, c, q[2]));
        int len = 0;
        auto g = new Node[](0);

        while (g.length < K && !queue.empty) {
            auto n = queue.front;
            queue.popFront;
            auto nr = n[0];
            auto nc = n[1];
            if (used[nr][nc]) continue;
            g ~= n;
            used[nr][nc] = true;
            foreach (i; 0..4) {
                auto nnr = nr + dr[i];
                auto nnc = nc + dc[i];
                if (nnr >= 0 && nnr < H && nnc >= 0 && nnc < W && !used[nnr][nnc] && board[nnr][nnc] != 0) {
                    queue.insert(Node(nnr, nnc, board[nnr][nnc]));
                }
            }
        }

        if (g.length == K)
            groups ~= g;
        else {
            foreach (gg; g) {
                used[gg[0]][gg[1]] = false;
            }
        }

        //writeln(groups.length);
    }

    dump;
}
