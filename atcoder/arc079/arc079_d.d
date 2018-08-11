import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto G = new int[][](N);
    auto H = new int[][](N);
    auto D = new int[](N);
    foreach (i, p; readln.split.map!(to!int).enumerate) {
        G[p-1] ~= i.to!int;
        H[i] ~= p-1;
        D[p-1] += 1;
    }
    auto A = new int[](N);
    fill(A, -1);

    
    int mex(int n) {
        auto X = G[n].map!(j => A[j]).filter!"a >= 0".array.sort().uniq().array;
        int m = X.length.to!int;
        foreach (i; 0..X.length.to!int) {
            if (i != X[i]) {
                m = i;
                break;
            }
        }
        return m;
    }

    bool check() {
        return N.iota.map!(i => mex(i) == A[i]).all;
    }
    
    void dfs(int n) {
        A[n] = mex(n);
        foreach (m; H[n]) {
            D[m] -= 1;
            if (D[m] == 0 && A[m] == -1) {
                dfs(m);
            }
        }
    }


    
    foreach (i; 0..N) {
        if (D[i] == 0 && A[i] == -1) {
            dfs(i);
        }
    }

    if (!A.canFind(-1)) {
        writeln(check ? "POSSIBLE" : "IMPOSSIBLE");
        return;
    }

    foreach (i; 0..N) {
        if (A[i] == -1) {
            int k = -1;
            foreach (j; H[i]) if (A[j] == -1) k = j;
            
            int m = mex(i);
            auto AA = new int[](N);
            auto DD = new int[](N);
            foreach (j; 0..N) AA[j] = A[j], DD[j] = D[j];
            A[i] = m;
            dfs(k);
            if (check) {
                writeln("POSSIBLE");
                return;
            }
            
            foreach (j; 0..N) A[j] = AA[j], D[j] = DD[j];
            auto X = G[i].map!(j => A[j]).filter!"a >= 0".array ~ m;
            X = X.sort().uniq().array;
            m = X.length.to!int;
            foreach (j; 0..X.length.to!int) {
                if (j != X[j]) {
                    m = j;
                    break;
                }
            }
            A[i] = m;
            dfs(k);
            if (check) {
                writeln("POSSIBLE");
                return;
            }
            break;
        }
    }

    writeln("IMPOSSIBLE");
}
