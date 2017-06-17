import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

immutable int INF = 1 << 28;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto edges = new int[][](N);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        edges[s[0] - 1] ~= s[1] - 1;
        edges[s[1] - 1] ~= s[0] - 1;
    }


    auto VU = new bool[int][](N);

    foreach (u; edges[0]) {
        foreach (v; edges[u]) {
            if (v != 0)
                VU[v][u] = true;
        }
    }


    bool ok = false;
    
    foreach (i; 1..N) {
        foreach (j; edges[i]) {
            if (j < i) continue;
            bool ij, ji;
            if (j in VU[i]) VU[i].remove(j), ij = true;
            if (i in VU[j]) VU[j].remove(i), ji = true;
            
            auto il = VU[i].keys.length;
            auto jl = VU[j].keys.length;

            if (il == 1 && jl == 1 && VU[i].keys[0] != VU[j].keys[0])
                ok = true;
            if (il > 0 && jl > 0 && max(il, jl) > 1)
                ok = true;

            if (ij) VU[i][j] = true;
            if (ji) VU[j][i] = true;
        }
    }

    writeln(ok ? "YES" : "NO");
}

