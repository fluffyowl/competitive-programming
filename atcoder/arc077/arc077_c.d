import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto A = readln.split.map!(to!int).array;
    A[] -= 1;

    auto cnt = new int[][](M);
    foreach (i; 1..N) cnt[A[i]] ~= i; 

    auto imos = new long[](M * 2);
    foreach(i; 0..N-1) {
        if (A[i] <= A[i+1]) {
            imos[A[i] + 1] += 1;
            imos[A[i + 1] + 1] -= 1;
        } else {
            imos[A[i] + 1] += 1;
            imos[A[i + 1] + M + 1] -= 1;
        }
    }
    foreach (i; 0..2*M-1) imos[i+1] += imos[i];
    debug imos.writeln;

    long ans = 0;
    foreach (i; 0..N-1) {
        ans += min((A[i+1] + M - A[i]) % M, A[i+1] + 1);
    }

    long tmp = ans;
    debug tmp.writeln;
    foreach (x; 0..M-1) {
        foreach (i; cnt[x]) tmp += (A[i] + M - A[i-1]) % M;
        tmp -= imos[x] + imos[x+M];
        debug tmp.writeln;
        ans = min(ans, tmp);
    }

    ans.writeln;
}
