import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


int N, M, K;
string[] S;

class Kosaraju {
    int N;
    int[][] adj;
    int[][] rev_adj;
    int g;
    int[] group;
    int[][] group_n;
    int[][] group_adj;
    int[][] group_adj_rev;
    string[][] group_s;

    this(int n) {
        N = n;
        adj = new int[][](N);
        rev_adj = new int[][](N);
        group = new int[](N);
    }

    void add_edge(int from, int to) {
        adj[from] ~= to;
        rev_adj[to] ~= from;
    }

    void run() {
        int[] ord;
        auto used = new bool[](N);
        foreach (i; 0..N)
            if (!used[i])
                dfs1(i, ord, used);
        foreach (i; 0..N) used[i] = false;
        auto g_num = 0;
        foreach (i; iota(N-1, -1, -1)) {
            if (!used[ord[i]]) {
                dfs2(ord[i], g_num, used);
                g_num += 1;
            }
        }

        g = group.reduce!(max)+1;
        group_n = new int[][](g);
        foreach (i; 0..N)
            group_n[group[i]] ~= i;
        
        group_adj = new int[][](g);
        group_adj_rev = new int[][](g);
        foreach (i; 0..N)
            foreach (j; adj[i])
                if (group[i] != group[j])
                    group_adj_rev[group[j]] ~= group[i];
        foreach (i; 0..g) {
            group_adj_rev[i] = group_adj_rev[i].sort().uniq.array;
        }

        group_s = new string[][](g);
        foreach (i; 0..N) {
            group_s[group[i]] ~= S[i];
        }
        foreach (i; 0..g) {
            group_s[i].sort();
        }
    }
  
    void dfs1(int from, ref int[] ord, ref bool[] used) {
        if (used[from]) return;
        used[from] = true;
        foreach (to; adj[from]) 
            if (!used[to])
                dfs1(to, ord, used);
        ord ~= from;
    }

    void dfs2(int from, int g_num, ref bool[] used) {
        if (used[from]) return;
        used[from] = true;
        group[from] = g_num;
        foreach (to; rev_adj[from])
            if (!used[to])
                dfs2(to, g_num, used);
    }


    void solve() {
        run;
        auto dp = new string[][](g, K+1);
        fill(dp[0], "~");
        dp[0][0] = "";

        foreach (n; 1..g) {
            foreach (i; 0..K+1) {
                dp[n][i] = "~";
                foreach (m; group_adj_rev[n]) {
                    dp[n][i] = min(dp[n][i], dp[m][i]);
                    foreach (j; max(0, i-group_s[n].length.to!int)..i+1) {
                        dp[n][i] = min(dp[n][i],
                                       dp[m][j] ~ group_s[n][0..i-j].join(""));
                        //writeln(n, " ", m, " ", i, " ", j," ",
                        //        dp[m][j], " ", group_s[n][0..i-j].join(""));
                    }
                }
            }
        }

        //group_s.each!(writeln);
        //dp.writeln;
        string ans = "~";
        foreach (i; 0..g)
            ans = min(ans, dp[i][K]);
        writeln(ans == "~" ? "-1" : ans);
    }
}


void main() {
    auto s = readln.split.map!(to!int);
    N = s[0];
    M = s[1];
    K = s[2];
    S = readln.split.array;
    S ~= "~";

    auto scc = new Kosaraju(N+1);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        scc.add_edge(s[0]-1, s[1]-1);
    }
    foreach (i; 0..N) {
        scc.add_edge(N, i);
    }

    scc.solve;

}
