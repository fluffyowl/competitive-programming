import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    immutable long MOD = 10^^9 + 7;
    
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];

    if (M > N) {
        writeln(0);
        return;
    }

    auto cnt = new int[](N+1);
    foreach (i; iota(M, N+1, M)) cnt[i] = 1;
    long ans = 1L * N/M * (N/M - 1) % MOD;

    for (int i = M+1; i <= N; ++i) {
        if (cnt[i] == 0) continue;
        ans -= 1L * N/i * (N/i - 1) % MOD * cnt[i] % MOD;
        ans = (ans + MOD) % MOD;
        for (int j = i + i; j <= N; j += i) cnt[j] -= cnt[i];
    }

    foreach (i; 1..N-1) ans = ans * i % MOD;
    ans.writeln;
}

