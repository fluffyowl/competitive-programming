import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    auto B = readln.split.map!(c => c == "1").array;

    int[][int] rev;
    foreach (i, a; A.enumerate) 
        rev[a] ~= i.to!int;
    
    BitArray bs;
    bs.length = N * 2 - 1;
    foreach (i; 0..N)
        bs[i] = B[i];
    
    BitArray ans;
    ans.length = N * 2 - 1;

    foreach (c; rev.keys) {
        BitArray tmp;
        tmp.length = N * 2 - 1;
        
        foreach (i; rev[c]) {
            BitArray bsbs = bs.dup;
            bsbs <<= i;
            tmp |= bsbs;
        }

        ans ^= tmp;
    }

    (2*N-1).iota.map!(i => ans[i] ? "ODD" : "EVEN").each!writeln;
}

