import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto N = readln.chomp.to!int;
    auto aa = readln.chomp.to!int;
    auto AO = readln.split.map!(to!int).array;
    AO.sort();
    auto A = AO.dup;
    auto bb = readln.chomp.to!int;
    auto BO = readln.split.map!(to!int).array;
    BO.sort();
    auto B = BO.dup;

    
    int ans = 0;
    
    foreach (k; 0..N) {
        bool played = false;
        int pi, pj;
        foreach (i; 0..A.length.to!int) {
            foreach (j; iota(B.length.to!int-1, -1, -1)) {
                if (A[i] > B[j]) {
                    pi = i;
                    pj = j;
                    played = true;
                    break;
                }
            }
            if (played) break;
        }

        if (played) {
            A = A[0..pi] ~ A[pi+1..$];
            B = B[0..pj] ~ B[pj+1..$];
            ans += 1;
            if (A.length == 0) A = AO.dup;
            if (B.length == 0) B = BO.dup;
        }
        else {
            A = A[1..$];
            B = B[0..$-1];
            if (A.length == 0) A = AO.dup;
            if (B.length == 0) B = BO.dup;
        }
    }

    ans.writeln;
}

