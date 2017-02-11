import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;

    short[] maru;
    foreach (i; 0..N)
        if (S[i] == 'o')
            maru ~= i.to!short;

    DList!short qn;
    DList!short qd;
    short start = 0;
    foreach (m; maru)
        start |= (1 << m);
    qn.insert(start);
    qd.insert(1.to!short);
    int ans = 10;

    while (!qn.empty) {
        auto node = qn.back;
        auto depth = qd.back;
        qn.removeBack;
        qd.removeBack;

        if (node == ((1 << N)-1))
            ans = min(ans, depth);
        
        foreach (i; 0..N) {
            short next = node;
            foreach (m; maru) {
                next |= (1 << ((m+i) % N));
            }
            if (next != node) {
                qn.insert(next);
                qd.insert(((depth.to!short)+(1.to!short)).to!short);
            }
        }
    }

    ans.writeln;
    
}
