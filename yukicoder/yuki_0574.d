import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!long);
    auto F = s[0];
    auto N = s[1];
    auto K = s[2];
    real ans = 0;

    foreach (i; 1..F+1) { // 上からK番目の出目
        foreach (a; 0..N+1) { // iより小さい目が出た回数
            foreach (b; 0..N+1) { // iより大きい目が出た回数
                auto c = N - a - b; // iの目が出た回数
                if (i == 1 && a != 0) continue;
                if (i == F && b != 0) continue;
                if (c < 1) continue;
                if (b >= K || b + c < K) continue;
                long A = i - 1;
                long B = F - i;
                real tmp = 1;
                foreach (k; 1..a+1) tmp = tmp * A / F;
                foreach (k; 1..b+1) tmp = tmp * B / F;
                foreach (k; 1..c+1) tmp = tmp * 1 / F;
                foreach (k; 1..a+1) tmp = tmp * k / k;
                foreach (k; 1..b+1) tmp = tmp * (k + a) / k;
                foreach (k; 1..c+1) tmp = tmp * (k + a + b) / k;
                ans += tmp * i;
            }
        }
    }

    writefln("%.09f", ans);
}

