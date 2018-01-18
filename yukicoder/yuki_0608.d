import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


int solve(int N, int X, bool[] s) {
    int left = N-1;
    int right = 0;
    int cnt = 0;
    foreach (i; 0..N) {
        if (s[i]) {
            left = min(left, i);
            right = max(right, i);
            cnt += 1;
        }
    }

    int ans = 0;
    int x = X;

    for (; x > left; --x) {
        cnt += s[x-1] ? -1 : 1;
        s[x-1] ^= 1;
        ans += 1;
    }

    for (; cnt > 0; ++x) {
        if (s[x]) {
            cnt += s[x+1] ? -1 : 1;
            s[x+1] ^= 1;
            cnt += s[x] ? -1 : 1;
            s[x] ^= 1;
            ans += 2;
        }
        if (cnt == 0) break;
        ans += 1;
        cnt += s[x+1] ? -1 : 1;
        s[x+1] ^= 1;
    }

    return ans;
}


void main() {
    auto X = readln.chomp.to!int - 1;
    auto S = readln.chomp.map!(c => c == '#').array;
    auto T = S.dup; T.reverse();
    auto N = S.length.to!int;


    min(solve(N, X, S), solve(N, N-X-1, T)).writeln;
}

