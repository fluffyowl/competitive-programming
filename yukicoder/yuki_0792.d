import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


void main() {
    auto N = readln.chomp.to!int;
    dchar[] ans;
    ans ~= 'A';
    ans ~= '=';
    bool t = true;
    bool f = true;

    foreach (i; 0..1<<N) {
        auto s = readln.split.map!(to!int).array;
        if (s.back == 1) f = false;
        if (s.back == 0) t = false;
        if (s.back == 0) continue;
        if (ans.back != '=') ans ~= '∨';
        ans ~= '(';
        foreach (j; 0..N) {
            if (j > 0) ans ~= '∧';
            if (!s[j]) ans ~= '¬';
            ans ~= 'P';
            ans ~= '_';
            ans ~= (j+1).to!string.to!(dchar[]);
        }
        ans ~= ')';
    }

    if (t) {
        writeln("A=⊤");
    } else if (f) {
        writeln("A=⊥");
    } else {
        writeln(ans);
    }
}

