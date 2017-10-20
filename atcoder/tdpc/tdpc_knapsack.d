import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0], W = s[1], C = s[2];
    auto WV = new Tuple!(int, int)[][](55);
    foreach (i; 0..N) {
        s = readln.split.map!(to!int);
        WV[s[2]] ~= tuple(s[0], s[1]);
    }


    auto dp = new int[][](55, 10101);

    foreach (c; 1..55) {
        foreach (c2; iota(c-1, -1, -1)) {
            auto tmp = dp[c2].dup;

            foreach (wv; WV[c]) {
                int w = wv[0], v = wv[1];
                foreach (i; iota(10100, -1, -1))
                    if (tmp[i] > 0 && i + w <= W)
                        tmp[i+w] = max(tmp[i+w], tmp[i] + v);
                if (w <= W)
                    tmp[w] = max(tmp[w], v);
            }

            foreach (i; 0..10101)
                dp[c2+1][i] = max(dp[c2+1][i], tmp[i]);
        }
    }

    dp[C][0..W+1].reduce!max.writeln;
}
