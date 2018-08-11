import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];

    int rev(int n) {
        auto S = n.to!(string);
        int ret = 0;
        foreach_reverse (c; S) {
            ret *= 10;
            ret += c - '0';
        }
        return ret;
    }

    if (N > M) swap(N, M);
    int[int][int] mem;


    foreach (xxx; 1..N+1) {
        foreach (yyy; xxx..M+1) {
            int x = xxx;
            int y = yyy;
            if (x in mem && y in mem[x]) continue;
            bool ok = true;
            bool ss = (x == 13 && y == 13);
            Tuple!(int, int)[] hoge = [];
            while (true) {
                if (x == 0 || y == 0) {
                    ok = false;
                    break;
                }
                if (x in mem && y in mem[x]) {
                    if (mem[x][y] == -1) {
                        ok = true;
                        break;
                    }
                    else {
                        ok = mem[x][y] == 1;
                        break;
                    }
                }

                mem[x][y] = -1;
                hoge ~= tuple(x, y);
                x = rev(x);
                if (x > y) swap(x, y);
                y = y - x;
                if (x > y) swap(x, y);
            }
            foreach (t; hoge) {
                int xx = t[0];
                int yy = t[1];
                mem[xx][yy] = ok;
            }
        }
    }

    long ans = 0;
    foreach (xx; 1..N+1) {
        foreach (yy; 1..M+1) {
            int x = xx;
            int y = yy;
            if (x > y) swap(x, y);
            ans += mem[x][y];
        }
    }

    ans.writeln;
}
