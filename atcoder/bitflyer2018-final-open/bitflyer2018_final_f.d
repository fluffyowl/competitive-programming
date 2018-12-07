import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto Q = s[2];
    auto A = H.iota.map!(_ => readln.chomp.map!(a => a == '#').array).array;

    auto mp = new RedBlackTree!(int)();
    foreach (i; 0..H-1) {
        foreach (j; 0..W-1) {
            bool x = (A[i][j] ^ A[i][j+1]) ^ (A[i+1][j] ^ A[i+1][j+1]);
            if (x) mp.insert(i * W + j);
        }
    }

    auto check = new Tuple!(int, int)[](4);

    while (Q--) {
        if (mp.length <= 1) {
            writeln("Yes");
        } else if (mp.length == 2) {
            int i = 0;
            foreach (x; mp) {
                check[i++] = tuple(x / W, x % W);
            }
            if (check[0][0] == check[1][0] || check[0][1] == check[1][1]) {
                writeln("Yes");
            } else {
                writeln("No");
            }
        } else if (mp.length == 4) {
            int i = 0;
            foreach (x; mp) {
                check[i++] = tuple(x / W, x % W);
            }
            check.sort();
            if (check[0][0] == check[1][0] &&
                check[1][1] == check[3][1] &&
                check[3][0] == check[2][0] &&
                check[2][1] == check[0][1]) {
                writeln("Yes");
            } else {
                writeln("No");
            }
        } else {
            writeln("No");
        }

        if (Q == 0) {
            break;
        }

        s = readln.split.map!(to!int);
        int r = s[0] - 1;
        int c = s[1] - 1;
        foreach (dr; -1..1) {
            foreach (dc; -1..1) {
                int nr = r + dr;
                int nc = c + dc;
                if (nr >= 0 && nr < H-1 && nc >= 0 && nc < W-1) {
                    if (mp.equalRange(nr * W + nc).empty) {
                        mp.insert(nr * W + nc);
                    } else {
                        mp.removeKey(nr * W + nc);
                    }
                }
            }
        }
    }
}
