import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


string S;
string T;

int compare(int i) {
    // -1 : docchimo
    //  0 : T < S
    //  1 : S < T
    if (i >= S.length && i >= T.length) return -1;
    if (i >= T.length) return 0;
    if (i >= S.length) return 1;

    if (S[i] == '?' && T[i] == 'a') return compare(i+1);
    if (S[i] == '?' && T[i] == 'z') return compare(i+1);
    if (S[i] == '?' && T[i] > 'a' && T[i] < 'z') return -1;

    if (S[i] == T[i]) return compare(i+1);
    if (S[i] >  T[i]) return 0;
    if (S[i] <  T[i]) return 1;

    assert(0);
}

void main() {
    auto N = readln.chomp.to!int;
    string[] SS;
    foreach (i; 0..N) SS ~= readln.chomp;
    T = readln.chomp;

    int saisho = 1;
    int haba = 0;
    foreach (i; 0..N) {
        S = SS[i];
        int c = compare(0);
        if (c == -1) haba += 1;
        else if (c == 1) saisho += 1;
    }

    string[] ans;
    foreach (i; saisho..saisho+haba+1) ans ~= i.to!string;
    ans.join(" ").writeln;

}
