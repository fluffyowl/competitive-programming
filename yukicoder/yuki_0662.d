import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    int[string] marks;
    int[] rewards = new int[5];

    foreach (i; 0..5) {
        auto s = readln.split;
        marks[s[0]] = i;
        rewards[i] = s[1].to!int;
    }
    
    auto N1 = readln.chomp.to!int;
    auto A = N1.iota.map!(_ => marks[readln.chomp]).array;
    auto N2 = readln.chomp.to!int;
    auto B = N2.iota.map!(_ => marks[readln.chomp]).array;
    auto N3 = readln.chomp.to!int;
    auto C = N3.iota.map!(_ => marks[readln.chomp]).array;

    auto cnt = new int[5];
    foreach (c; C) cnt[c] += 1;

    long tot = 0;
    auto ans = new long[5];

    foreach (i; 0..N1) {
        foreach (j; 0..N2) {
            int a1 = A[i], a2 = A[(i+1)%N1], a3 = A[(i+2)%N1];
            int b1 = B[j], b2 = B[(j+1)%N2], b3 = B[(j+2)%N2];
            if (a1 == b1) tot += cnt[a1] * rewards[a1], ans[a1] += cnt[a1];
            if (a1 == b2) tot += cnt[a1] * rewards[a1], ans[a1] += cnt[a1];
            if (a2 == b2) tot += cnt[a2] * rewards[a2], ans[a2] += cnt[a2];
            if (a3 == b2) tot += cnt[a3] * rewards[a3], ans[a3] += cnt[a3];
            if (a3 == b3) tot += cnt[a3] * rewards[a3], ans[a3] += cnt[a3];
        }
    }

    writefln("%.09f", 1.0L * tot / N1 / N2 / N3);
    5.iota.each!(i => writeln(ans[i]));
}

