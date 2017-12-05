import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto N = readln.chomp.to!int;
    auto M = readln.chomp.to!int;
    auto S = readln.chomp;

    int ans = 0;

    for (int i = 0; i < M; ++i) {
        if (S[i] == 'I') {
            int cnt = 0;
            while (i < M - 2 && S[i+1] == 'O' && S[i+2] == 'I') {
                cnt += 1;
                if (cnt >= N) {
                    ans += 1;
                }
                i += 2;
            }
        }
    }

    ans.writeln;
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto N = readln.chomp.to!int;
    auto M = readln.chomp.to!int;
    auto S = readln.chomp;

    int ans = 0;

    for (int i = 0; i < M; ++i) {
        if (S[i] == 'I') {
            int cnt = 0;
            while (i < M - 2 && S[i+1] == 'O' && S[i+2] == 'I') {
                cnt += 1;
                if (cnt >= N) {
                    ans += 1;
                }
                i += 2;
            }
        }
    }

    ans.writeln;
}
