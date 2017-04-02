import std.stdio, std.array, std.string, std.conv, std.algorithm;
    import std.typecons, std.range, std.random, std.math, std.container;
    import std.numeric, std.bigint, core.bitop, core.stdc.string;
     
     
    void main() {
        auto S = readln.split.map!(to!int);
        auto K = S[1];
        auto A = readln.split.map!(to!int).filter!(a => a < K).array;
        A.sort();
        auto N = A.length.to!int;
     
        if (N == 0) {
            writeln(0);
            return;
        }
        
        if (N == 1) {
            writeln(A[0] >= K ? 1 : 0);
            return;
        }
     
     
        bool[5001] used;
        
        auto dp1 = new int[][](N);
        dp1[0] = [0, A[0]];
        foreach (i; 1..N) {
            memset(used.ptr, 0, used.sizeof);
            foreach (j; dp1[i-1]) {
                if (!used[j]) {
                    dp1[i] ~= j;
                    used[j] = true;
                }
                if (A[i] + j < K && !used[A[i]+j]) {
                    dp1[i] ~= A[i] + j;
                    used[A[i]+j] = true; 
                }
            }
            dp1[i].sort();
        }
     
        auto dp2 = new int[][](N);
        dp2[N-1] = [0, A[N-1]];
        foreach (i; iota(N-2, -1, -1)) {
            memset(used.ptr, 0, used.sizeof);
            foreach (j; dp2[i+1]) {
                if (!used[j]) {
                    dp2[i] ~= j;
                    used[j] = true;
                }
                if (A[i] + j < K && !used[A[i]+j]) {
                    dp2[i] ~= A[i] + j;
                    used[A[i]+j] = true;
                }
            }
            dp2[i].sort();
        }
     
     
        int ans = 0;
        
        foreach (i; 0..N) {
            bool required = false;
            int lb = K - A[i];
            
            if (i == 0) {
                if (dp2[1][$-1] >= lb) {
                    required = true;
                }
            }
            
            else if (i == N-1) {
                if (dp1[N-2][$-1] >= lb) {
                    required = true;
                }
            }
     
            else {
                int n = dp1[i-1].length.to!int;
                int m = dp2[i+1].length.to!int;
                int p1 = 0;
                int p2 = m-1;
                while (p1 < n && p2 >= 0) {
                    int s = dp1[i-1][p1] + dp2[i+1][p2];
                    if (s >= K) p2 -= 1;
                    else if (s < lb) p1 += 1;
                    else {required = true; break;}
                }
            }
     
            if (!required) ans += 1;
        }
     
        
        ans.writeln;
    }
