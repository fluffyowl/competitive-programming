import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    assert(A.length == N);

    auto G = new int[][](N);

    foreach (i; 0..N) {
        int l = i - A[i] / 2 - 1;
        int r = i + A[i] / 2 + 1;
        if (l >= 0 && r < N) {
            G[r] ~= l;
        }
    }

    auto ans = new dchar[](N);
    fill(ans, 'A');
    int right = -1;

    for (int i = 0; i < N; ++i) {
        if (ans[i] == 'A') {
            auto ng = new bool[](26);
            foreach (j; G[i]) {
                ng[ans[j]-'a'] = true;
            }
            for (char c = 'a'; c <= 'z'; ++c) {
                if (!ng[c-'a']) {
                    ans[i] = c;
                    break;
                }
            }
        }

        int goal = i + A[i] / 2;
        for (int j = max(right+1, i+1); j <= goal; ++j) {
            ans[j] = ans[i - (j - i)];
            right = j;
        }
    }

    ans.writeln;
}
