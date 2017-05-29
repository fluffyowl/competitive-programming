import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto X = s[1] + 1;
    
    int[] factors;

    for (int i = 2; i * i <= X; i++) {
        if (X % i == 0) factors ~= (i * i == X ? [i] : [i, X / i]);
    }


    int[int][int][int] mem;
    
    int dfs(int x, int k, int d) {
        if (d == N) return x == 1;
        if (x in mem && k in mem[x] && d in mem[x][k]) return mem[x][k][d];
        
        int ans = 0;
        foreach (i; k..factors.length.to!int) {
            if (x % factors[i] == 0) ans += dfs(x / factors[i], i, d+1);
        }

        return mem[x][k][d] = ans;
    }

    dfs(X, 0, 0).writeln;
}

