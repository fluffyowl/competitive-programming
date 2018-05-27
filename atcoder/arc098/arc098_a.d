import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.datetime;

void main() {
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;

    auto W = new int[](N+1);
    auto E = new int[](N+1);
    foreach (i; 0..N) W[i+1] = W[i] + (S[i] == 'W');
    foreach (i; 0..N) E[i+1] = E[i] + (S[i] == 'E');


    int ans = 1 << 29;

    foreach (i; 0..N) {
        int tmp = 0;
        if (i > 0) {
            tmp += W[i];
        }
        if (i < N-1) {
            tmp += E[N] - E[i+1];
        }
        ans = min(ans, tmp);
    }

    ans.writeln;
}
