import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto edges = new int[][](N);
    foreach (i; 0..N-1) {
        auto s = readln.split.map!(to!int);
        edges[s[0]-1] ~= s[1]-1;
        edges[s[1]-1] ~= s[0]-1;
    }

    if (N == 2) {
        writeln("Second");
        return;
    } else if (N == 3) {
        writeln("First");
        return;
    }

    
    bool first = false;
    
    int dfs(int n, int p) {
        int[] tmp;
        foreach (m; edges[n]) if (m != p)
            tmp ~= dfs(m, n);

        if (tmp.sum > 1)
            first = true;

        //writeln(n, tmp);
        return tmp.sum ? 0 : 1;
    }

    
    if (dfs(0, -1))
        first = true;
    
    writeln( first ? "First" : "Second" );
}
