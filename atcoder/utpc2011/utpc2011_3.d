import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

bool ok(string s) {
    auto n = s.length.to!int;
    int ci = 0, cw = 0;
    foreach (i; 0..n) {
        if (s[i] == 'i') ci++;
        if (s[i] == 'w') cw++;
    }
    if (ci != 2 && cw != 1) return false;
    if (n % 2 == 1 && s[n/2] != 'i' && s[n/2] != 'w') return false;
    foreach (i; 0..n/2) {
        string t = s[i].to!string ~ s[n-i-1].to!string;
        if (t != "ii" && t != "ww" && t != "()" && t != ")(" && t != "[]" && t != "][" && t != "{}" && t != "}{") {
            return false;}
    }
    return true;
}

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;
    int ans = 0;

    foreach (i; 0..(1 << N)) {
        string s = "";
        foreach (j; 0..N) if (i & (1 << j)) s ~= S[j];
        if (ok(s)) ans = max(ans, s.length.to!int);
    }

    ans.writeln;
}
