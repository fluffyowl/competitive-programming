import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    auto G = new int[][](N);
    foreach (_; 0..N-1) {
        auto s = readln.split.map!(to!int);
        G[s[0]-1] ~= s[1]-1;
        G[s[1]-1] ~= s[0]-1;
    }

    if (N == 2) {
        writeln(A[0] == A[1] ? "YES" : "NO");
        return;
    }

    int root;
    foreach (i; 0..N) {
        if (G[i].length >= 2) {
            root = i;
            break;
        }
    }


    bool dfs(int n, int p) {
        if (G[n].length == 1) {
            return true;
        }
        
        long sm = 0;
        long mx = 0;
        foreach (m; G[n]) {
            if (m != p) {
                if (!dfs(m, n)) return false;
                sm += A[m];
                mx = max(mx, A[m]);
            }
        }

        if (sm < A[n] || sm > A[n] * 2) return false;
        long k = sm - A[n];
        if (k > sm - mx) return false;
        A[n] -= k;
        
        return n == root ? A[n] == 0 : (A[n] >= 0);
    }

    writeln(dfs(root, -1) ? "YES" : "NO");
}
