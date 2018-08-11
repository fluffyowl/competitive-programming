import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto A = s[2];
    auto B = s[3];
    auto ans = new dchar[][](N, M);

    bool solve(bool hoge) {
        foreach (i; 0..N) fill(ans[i], '.');

        int a = A;
        int b = B;
        
        if (N >= 3 && M >= 3 && N % 2 == 1 && M % 2 == 1 && hoge) {
            if (a >= 1) {
                ans[$-3][$-3] = '<';
                ans[$-3][$-2] = '>';
            }
            if (a >= 2) {
                ans[$-1][$-2] = '<';
                ans[$-1][$-1] = '>';
            }
            if (b >= 1) {
                ans[$-3][$-1] = '^';
                ans[$-2][$-1] = 'v';
            }
            if (b >= 2) {
                ans[$-2][$-3] = '^';
                ans[$-1][$-3] = 'v';
            }
            a -= 2;
            b -= 2;
        }

        if (N % 2 == 1)
            for (int c = 0; c < M - M % 2 && ans[$-1][c] == '.' && ans[$-1][c+1] == '.' && a > 0; c += 2)
                ans[$-1][c] = '<', ans[$-1][c+1] = '>', a -= 1;
        if (M % 2 == 1)
            for (int r = 0; r < N - N % 2 && ans[r][$-1] == '.' && ans[r+1][$-1] == '.' && b > 0; r += 2)
                ans[r][$-1] = '^', ans[r+1][$-1] = 'v', b -= 1;

        int r = 0, c = 0;
        while (r < N - N % 2 && c < M - M % 2 && a > 0 && ans[r][c] == '.') {
            ans[r][c] = '<';
            ans[r][c+1] = '>';
            if (a >= 2) {
                ans[r+1][c] = '<';
                ans[r+1][c+1] = '>';
            }
            a -= 2, c += 2;
            if (c >= M - M % 2) r += 2, c = 0;
        }

        while (r < N - N % 2 && c < M - M % 2 && b > 0 && ans[r][c] == '.') {
            ans[r][c] = '^';
            ans[r+1][c] = 'v';
            if (b >= 2) {
                ans[r][c+1] = '^';
                ans[r+1][c+1] = 'v';
            }
            b -= 2, c += 2;
            if (c >= M - M % 2) r += 2, c = 0;
        }

        return a <= 0 && b <= 0;
    }

    
    if (solve(false)) {
        writeln("YES");
        ans.each!writeln;
    } else if (solve(true)) {
        writeln("YES");
        ans.each!writeln;
    } else {
        writeln("NO");
    }
}
