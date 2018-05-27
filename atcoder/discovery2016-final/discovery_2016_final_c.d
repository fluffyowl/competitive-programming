import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable long MOD = 10^^9 + 7;
    
    auto S = readln.chomp;
    auto N = S.length.to!int;
    auto K = readln.chomp.to!int;
    K = min(K, 2*N);
    auto P = new Tuple!(int, int)[](N/2);
    auto G = new int[][](N/2);
    auto root = new bool[](N/2);
    root.fill(true);
    long inv2 = powmod(2, MOD-2, MOD);

    auto stack = new Tuple!(int, int)[](N/2);
    for (int i = 0, p = 0, sp = -1; i < N; ++i) {
        if (S[i] == '(') {
            if (sp >= 0) G[stack[sp][1]] ~= p, root[p] = false;
            stack[++sp] = tuple(i, p++);
        } else {
            P[stack[sp][1]] = tuple(stack[sp][0], i);
            sp--;
        }
    }

    auto dp = new long[][](N/2, K+1);
    auto tmp = new long[][](2, N+1);
    
    void dfs(int n) {
        foreach (m; G[n]) dfs(m);

        int M = P[n][1] - P[n][0] + 1;
        tmp[0].fill(0);
        tmp[1].fill(0);
        
        tmp[0][0] = 2;
        tmp[0][1] = 2;
        int cur = 0, tar = 1;
        
        foreach (m; G[n]) {
            tmp[tar].fill(0);
            for (int i = 0; i <= M; ++i) {
                if (tmp[cur][i] == 0) continue;
                for (int j = 0; j <= K/2 && i+j <= M && dp[m][j] > 0; ++j) {
                    (tmp[tar][i+j] += tmp[cur][i] * dp[m][j] % MOD * inv2 % MOD) %= MOD;
                }
                for (int j = 0; j <= K/2 && abs(i-j) <= M && dp[m][j] > 0; ++j) {
                    (tmp[tar][abs(i-j)] += tmp[cur][i] * dp[m][j] % MOD * inv2 % MOD) %= MOD;
                }
            }
            swap(cur, tar);
        }

        for (int i = 0; i <= K/2; ++i) dp[n][i] = tmp[cur][i];
    }

    
    long ans = 1;
    foreach (i; 0..N/2) {
        if (!root[i]) continue;
        dfs(i);
        long t = 0;
        foreach (j; 0..K/2+1) t = (t + dp[i][j]) % MOD;
        ans = ans * t % MOD;
    }

    ans.writeln;
}

long powmod(long a, long x, long m) {
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}
