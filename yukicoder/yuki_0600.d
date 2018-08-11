import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

const long MOD = 10^^9 + 7;
const long BASE = 97;


void main() {
    auto N = readln.chomp.to!int;
    int[] B;
    for (int i = 0, M = N; M > 0; i+=1, M/=2) if (M % 2) B ~= i;
    int s = 0;
    string ans = "";
    char c = 'a';

    foreach (i; 0..B.length) {
        if (c >= 'x') c = 'a';
        B[i] -= s;
        if (i + 1 == B.length) {
            foreach (_; 0..B[i]) ans ~= c;
        } else {
            foreach (_; 0..B[i]+1) ans ~= c;
            s += B[i];
            c += 1;
        }
    }

    auto sna = ans.dup;
    sna.reverse();
    ans = ans.to!string ~ "xyz" ~ sna.to!string;
    ans.writeln;
}

