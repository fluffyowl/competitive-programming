import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto h = s[2];
    auto w = s[3];

    if (H % h == 0 && W % w == 0) {
        writeln("No");
        return;
    }

    writeln("Yes");

    bool rot = false;
    if (H % h == 0) swap(H, W), swap(h, w), rot = true;
    auto ans = new int[][](H, W);

    int y = -10^^5;
    int z = H / h;
    int maxx = (-h + 1) * y;
    //int minx = (-H*y + z*y) / z;
    int x = maxx - 1;
    foreach (i; 0..H) {
        foreach (j; 0..W) {
            if (i % h == 0) ans[i][j] = x;
            else ans[i][j] = y;
        }
    }

    if (rot) {
        auto new_ans = new int[][](W, H);
        foreach (j; 0..W)
            foreach (i; 0..H)
                new_ans[j][i] = ans[i][j];
        foreach (i; 0..W) new_ans[i].map!(a => a.to!string).join(" ").writeln;
    } else {
        foreach (i; 0..H) ans[i].map!(a => a.to!string).join(" ").writeln;
    }

}
