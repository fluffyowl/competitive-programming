import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!long);
    auto A = s[0];
    auto B = s[1];
    auto C = s[2];
    auto S = readln.chomp.map!(c => (c - '0').to!int).array;
    auto N = S.length.to!int;
    long ans = 1L << 59;

    auto seg1 = new int[](N);
    auto seg2 = new int[](N);
    seg1[0] = 1;
    seg2[N-1] = 1;
    foreach (i; 1..N) seg1[i] = S[i] == S[i-1] ? seg1[i-1] : seg1[i-1] + 1;
    foreach_reverse (i; 0..N-1) seg2[i] = S[i] == S[i+1] ? seg2[i+1] : seg2[i+1] + 1; 
    
    foreach (a; 0..N+1) { // 先頭に追加する回数
        int b = N - a; // 末尾に追加する回数
        int s1 = a == 0 ? 0 : seg1[a-1];
        int s2 = a == N ? 0 : seg2[a];
        int flip = max(s1, s2) - 1;
        if (a > 0 && a < N && s1 == s2 && S[a] == S[a-1]) flip += 1;
        if (s1 >= s2 && S[0] == 1) flip += 1;
        if (s1 < s2 && S[N-1] == 0) flip += 1;
        ans = min(ans, a * A + b * B + flip * C);
    }

    ans.writeln;
}
