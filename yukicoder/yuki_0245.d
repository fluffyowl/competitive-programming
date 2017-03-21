import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    int N = readln.chomp.to!int;
    auto p = iota(N).map!(_ => readln.split.map!(to!int).array).array;
    if (N == 1) {
        writeln(1);
        return;
    }

    int ans;
    int[4] e1 = [0, 0, 2, 2];
    int[4] e2 = [0, 2, 0, 2];
    foreach (i; 0..N) {
        foreach (j; i+1..N) {
            foreach (e; 0..4) {
                int tmp_ans;
                int p1x = p[i][e1[e]];
                int p1y = p[i][e1[e]+1];
                int p2x = p[j][e2[e]];
                int p2y = p[j][e2[e]+1];
                if (p1x == p2x && p1y == p2y) continue;
                foreach (k; 0..N) {
                    int p3x = p[k][0];
                    int p3y = p[k][1];
                    int p4x = p[k][2];
                    int p4y = p[k][3];
                    long a = (p1x - p2x) * (p3y - p1y) + (p1y - p2y) * (p1x - p3x);
                    long b = (p1x - p2x) * (p4y - p1y) + (p1y - p2y) * (p1x - p4x);
                    if (a * b <= 0)
                        tmp_ans++;
                }

                ans = max(ans, tmp_ans);
            }
        }
    }
    
    writeln(ans);
}

