import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

immutable int INF = 1 << 29;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.split.map!(to!int).array).array;


    int ans = 0;

    foreach (i; 0..H) {
        if (i != 0) foreach (j; 0..W) A[i][j] ^= 1;

        int maxtmp = 0;
        
        foreach (j; 0..W) {
            int tmp = 0;
            int[] B = A[i].dup;
            foreach (k; 0..j) {
                tmp += B[k];
                if (k < W - 1) B[k + 1] ^= 1;
            }
            for (int k = W - 1; k >= j; k--) {
                tmp += B[k];
                if (k > 0) B[k - 1] ^= 1;
            }
            maxtmp = max(tmp, maxtmp);
        }

        ans += maxtmp;
    }


    ans.writeln;
}
