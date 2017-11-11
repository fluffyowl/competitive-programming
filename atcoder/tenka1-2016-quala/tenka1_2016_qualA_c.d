import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;
     
void main() {
    auto N = readln.chomp.to!int;
    auto edges = new bool[][](26, 26);

    foreach (i; 0..N) {
        auto s = readln.split;
        auto A = s[0];
        auto B = s[1];
        bool found = false;
        
        foreach (j; 0..min(A.length, B.length)) {
            if (A[j] != B[j]) {
                edges[B[j]-'a'][A[j]-'a'] = true;
                found = true;
                break;
            }
        }

        if (!found && B.length < A.length) {
            writeln(-1);
            return;
        }
    }


    auto q = new BinaryHeap!(Array!int, "a > b")();
    int[] toposo;
    foreach (i; 0..26) if (edges[i].sum == 0) q.insert(i);

    while (!q.empty) {
        int n = q.front;
        q.removeFront;
        toposo ~= n;
        foreach (m; 0..26) {
            if (edges[m][n]) {
                edges[m][n] = false;
                if (edges[m].sum == 0) q.insert(m);
            }
        }
    }

    
    if (26.iota.map!(i => edges[i].any).any) {
        writeln(-1);
    } else {
        char[] ans;
        foreach (c; toposo) ans ~= c.to!char + 'a';
        foreach (i; 0..26.to!char) if (ans.map!(a => a != i + 'a').all) ans ~= i + 'a';
        ans.writeln;
    }
}
