import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    auto cnt = new long[string][](N+1);
    long ans = 0;

    foreach (mask; 0..(1<<N)) {
        string a = "";
        string b = "";
        foreach (i; 0..N) {
            if ((1 << i) & mask) {
                a ~= S[i];
            } else {
                b = S[i] ~ b;
            }
        }
        cnt[mask.popcnt][a~b] += 1;
    }

    foreach (mask; 0..(1<<N)) {
        string a = "";
        string b = "";
        foreach (i; 0..N) {
            if ((1 << i) & mask) {
                a ~= S[i+N];
            } else {
                b = S[i+N] ~ b;
            }
        }
        if ((b ~ a) in cnt[N-mask.popcnt]) {
            ans += cnt[N-mask.popcnt][b ~ a];
        }
    }

    ans.writeln;
}
