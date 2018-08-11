import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split;
    auto N = s[0].to!int;
    auto p = s[1].split("/")[0].to!real;
    auto q = s[1].split("/")[1].to!real;
    auto P = 1.0L * p / q;
    auto A = N.iota.map!(_ => readln.split.map!(to!int).array).array;
    auto B = N.iota.map!(i => tuple(A[i].sum, i)).array;
    B.sort!"a[0] == b[0] ? a[1] < b[1] : a[0] > b[0]";

    auto dpdp = new real[][](N, N); // i勝がj勝に移る確率
    foreach (i; 0..N) fill(dpdp[i], 0);
    
    foreach (i; 0..N) { // 元はi勝
        foreach (j; 0..i+1) { // 勝ちがそのまま残る数
            foreach (k; 0..N-i) { // 負けがそのまま残る数
                int win = i;
                int lose = N-win-1;
                real tmp = 1;
                foreach_reverse (x; 1..win+1) {
                    if (x > win - j) tmp = tmp * x;
                    if (x <= j) tmp /= x;
                    if (x <= j) tmp *= P;
                    else tmp *= 1 - P;
                }
                foreach_reverse (x; 1..lose+1) {
                    if (x > lose - k) tmp = tmp * x;
                    if (x <= k) tmp /= x;
                    if (x <= k) tmp *= P;
                    else tmp *= 1 - P;
                }
                dpdp[win][j + lose - k] += tmp;
            }
        }
    }
    

    auto dp = new real[][](N+1, N+1);
    foreach (i; 0..N+1) fill(dp[i], 0);
    dp[0][N-1] = 1;

    foreach (i; 0..N) {
        foreach (j; 0..N) { // 前の人が勝った数
            foreach (k; 0..N) { // 自分が勝った数
                int limit = (i == 0 || B[i][1] > B[i-1][1]) ? j : j - 1;
                if (k > limit) continue;
                dp[i+1][k] += dp[i][j] * dpdp[B[i][0]][k];
            }
        }
    }

    writefln("%.14f", dp[N].sum);
}
