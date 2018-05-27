import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.chomp.map!(a => (a - 'a').to!int).array).array;

    auto can_pair = new bool[][](H, H);

    foreach (i; 0..H) {
        foreach (j; 0..H) {
            auto cnt1 = new int[](26);
            auto cnt2 = new int[](26);
            foreach (k; 0..W) {
                cnt1[A[i][k]] += 1;
                cnt2[A[j][k]] += 1;
            }
            if (26.iota.map!(a => cnt1[a] == cnt2[a]).all) {
                can_pair[i][j] = true;
                can_pair[j][i] = true;
            }
        }
    }

    auto used = new bool[](H);
    int[] stack;
    int center = -1;

    bool dfs(int n) {
        if (n >= H) {
            auto B = new int[][](H, W);
            foreach (i; 0..H/2) {
                B[i] = A[stack[i*2]].dup;
                B[H-i-1] = A[stack[i*2+1]].dup;
            }
            if (center != -1) {
                B[H/2] = A[center].dup;
            }

            auto col_used = new bool[](W);
            bool center = false;
            
            foreach (j; 0..W) {
                if (col_used[j]) continue;
                foreach (k; j+1..W) {
                    if (H.iota.map!(i => B[i][j] == B[H-i-1][k]).all) {
                        col_used[j] = true;
                        col_used[k] = true;
                        break;
                    }
                }

                if (!col_used[j]) {
                    if (W % 2 == 0 || center) return false;
                    if ((H/2).iota.map!(i => B[i][j] == B[H-i-1][j]).all) {
                        center = true;
                        col_used[j] = true;
                    }
                }
            }

            return true;
        }
        if (used[n]) return dfs(n+1);

        used[n] = true;
        stack ~= n;

        foreach (i; 0..H) {
            if (used[i] || !can_pair[n][i]) continue;
            used[i] = true;
            stack ~= i;
            if (dfs(n+1)) return true;
            used[i] = false;
            stack.popBack;
        }

        stack.popBack;

        if (center == -1 && H % 2 == 1) {
            center = n;
            if (dfs(n+1)) return true;
            center = -1;
        }
        
        used[n] = false;

        return false;
    }

    writeln(dfs(0) ? "YES" : "NO");
}
