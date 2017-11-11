import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

const long INF = 1L << 59;

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;

    int ans = 1;
    for (int i = 0; i < N; ++i) {
        int tmp = 1;
        for (int j = 1; i - j >= 0 && i + j < N; ++j) {
            if (S[i+j] == S[i-j]) tmp += 2;
        }
        ans = max(ans, tmp);
    }

    for (int i = 0; i < N - 1; ++i) {
        int l = i;
        int r = i + 1;
        int tmp = 0;
        for (int j = 0; l - j >= 0 && r + j < N; ++j) {
            if (S[l-j] == S[r+j]) tmp += 2;
        }
        ans = max(ans, tmp);
    }
    ans.writeln;
}

