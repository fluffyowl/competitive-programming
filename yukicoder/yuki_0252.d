import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


void main() {
    auto T = readln.chomp.to!int;
    const auto G = "good";
    const auto P = "problem";

    foreach (t; 0..T) {
        auto S = readln.chomp;
        auto N = S.length.to!int;

        auto cnt = new int[](N);
        fill(cnt, 1 << 30);

        foreach (i; 4..N-6) {
            cnt[i] = 0;
            foreach (j; 0..7) {
                if (S[i+j] != P[j]) cnt[i] += 1;
            }
        }
        foreach (i; iota(N-2, -1, -1)) cnt[i] = min(cnt[i], cnt[i+1]);
        //cnt.writeln;

        auto cnt_problem = new int[](N);
        foreach (i; 0..N-6) {
            if (S[i..i+7] == P) cnt_problem[i] = 1;
        }
        foreach (i; 0..N-1) cnt_problem[i+1] += cnt_problem[i];


        int ans = 1 << 30;
        foreach (i; 0..N-10) {
            int cnt_g = 0;
            foreach (j; 0..4) {
                if (S[i+j] != G[j]) cnt_g += 1;
            }

            if (i < 7)
                ans = min(ans, cnt_g + cnt[i+4]);
            else
                ans = min(ans, cnt_g + cnt[i+4] + cnt_problem[i-7]);
            //writeln(i, " ", cnt[i+4], " ", cnt_g, " ", ans);
        }

        ans.writeln;
    }
}

