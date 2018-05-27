import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable long MOD = 998244353;
    
    auto S = readln.chomp;
    auto A = S.map!(c => (c - 'a').to!int).array;
    auto N = S.length.to!int;

    if (N.iota.map!(i => S[i] == S[0]).all) {
        1.writeln;
        return;
    }

    
    if (N <= 3) {
        S.brute_force.writeln;
        return;
    }

    auto dp = new long[][][][](N+1, 3, 4, 2); // i, mod3, 1つ前の文字, 1度でも連続したか
    dp[0][0][0][0] = 1;

    foreach (i; 0..N) 
        foreach (a; 0..3) 
            foreach (b; 0..3) 
                foreach (c; 0..2) 
                    foreach (d; 0..3) 
                        (dp[i+1][(a+d)%3][d][c||(b==d&&i!=0)] += dp[i][a][b][c]) %= MOD;

    long ans = (N-1).iota.map!(i => A[i] != A[i+1]).all;
    foreach (b; 0..3) (ans += dp[N][A.sum%3][b][1]) %= MOD;
    ans.writeln;
}

int brute_force(string S) {
    int N = S.length.to!int;
    bool[string] mem;
    
    void dfs(string s) {
        if (s in mem) return;
        mem[s] = true;
        
        foreach (i; 0..N-1) {
            if (s[i] == s[i+1]) continue;
            auto t = s.to!(dchar[]);
            if (s[i] + s[i+1] == 'a' + 'b') t[i] = t[i+1] = 'c';
            if (s[i] + s[i+1] == 'b' + 'c') t[i] = t[i+1] = 'a';
            if (s[i] + s[i+1] == 'c' + 'a') t[i] = t[i+1] = 'b';
            dfs(t.to!string);
        }
    }

    dfs(S);
    return mem.keys.length.to!int;
}
