import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    alias Node = Tuple!(int, "r", int, "c", int, "a", int, "b", int, "dir");
    auto dr = [-1, 0, 1, 0];
    auto dc = [0, 1, 0, -1];

    auto s = readln.split.map!(to!int);
    auto A = s[0];
    auto B = s[1];
    s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto C = H.iota.map!(_ => readln.chomp).array;

    auto stack = [Node(1, 1, 0, 0, 2)];
    auto used = new bool[][][][](H, W, A+1, B+1);
    bool ok = false;

    while (!stack.empty) {
        auto node = stack.back;
        stack.popBack;

        if (node.r == H-2 && node.c == W-2 && node.a == A && node.b == B) {
            ok = true;
            break;
        }

        if (used[node.r][node.c][node.a][node.b]) continue;
        used[node.r][node.c][node.a][node.b] = true;

        foreach (i; 0..4) {
            if ((i - node.dir + 4) % 4 == 1 && node.b < B) { // 右転換
                Node next;
                next.r = node.r + dr[i];
                next.c = node.c + dc[i];
                next.a = node.a;
                next.b = node.b + 1;
                next.dir = i;
                if (next.r < 0 || next.r >= H || next.c < 0 || next.c >= W) continue;
                if (C[next.r][next.c] == '#') continue;
                stack ~= next;
            }
            if ((i - node.dir + 4) % 4 == 3 && node.a < A) { // 左転換
                Node next;
                next.r = node.r + dr[i];
                next.c = node.c + dc[i];
                next.a = node.a + 1;
                next.b = node.b;
                next.dir = i;
                if (next.r < 0 || next.r >= H || next.c < 0 || next.c >= W) continue;
                if (C[next.r][next.c] == '#') continue;
                stack ~= next;
            }
            if (i == node.dir) {
                Node next;
                next.r = node.r + dr[i];
                next.c = node.c + dc[i];
                next.a = node.a;
                next.b = node.b;
                next.dir = i;
                if (next.r < 0 || next.r >= H || next.c < 0 || next.c >= W) continue;
                if (C[next.r][next.c] == '#') continue;
                stack ~= next;
            }
        }
    }

    writeln(ok ? "Yes" : "No");
}
