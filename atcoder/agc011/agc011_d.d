import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto S = readln.chomp.map!(a => a == 'A').array;
    foreach (i; 0..N) S ~= [0, 1];

    int p = 0;
    bool flip = false;

    while (p < N && K > 0) {
        int c = S[p] ^ flip;
        if (c) { // 先頭がA
            K -= 1;
            S[p] ^= 1;
        } else {
            p += 1;
            flip ^= 1;
            K -= 1;
        }
    }


    auto ans = new int[](N);

    if (K == 0) {
        foreach (i; 0..N) ans[i] = S[p+i] ^ flip;
    } else if (N % 2 == 0) {
        foreach (i; 0..N) ans[i] = i % 2;
    } else {
        ans[0] = S[p] ^ flip ^ (K % 2);
        foreach (i; 1..N) ans[i] = 1 - i % 2;
    }

    ans.map!(a => a ? 'A' : 'B').writeln;
}
