import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto S = '0' ~ readln.chomp;
    auto N = S.length.to!int - 1;

    if (S.back == '1') {
        writeln(-1);
        return;
    }
    if (S[1] == '0') {
        writeln(-1);
        return;
    }

    bool line = true;
    foreach (i; 1..N) if (S[i] == '0') line = false;
    if (line) {
        foreach (i; 0..N-1) {
            writeln(i+1, " ", i+2);
        }
        return;
    }

    int[][] ans;
    ans ~= [0, 1];
    int cur = 1;
    int cnt = 1;

    foreach (i; 1..N) {
        if (S[i] != S[N-i]) {
            writeln(-1);
            return;
        }
        if (i == 1) {
            continue;
        }
        if (S[i] == '1') {
            ans ~= [cur, ++cnt];
            cur = cnt;
        } else {
            ans ~= [cur, ++cnt];
        }
    }

    foreach (i; 0..N-1) {
        writeln(ans[i][0] + 1, " ", ans[i][1] + 1);
    }
}
