import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    Tuple!(int, int)[] A;
    foreach (i; 0..N) {
        s = readln.split.map!(to!int);
        A ~= tuple(s[0], s[1]);
    }

    int solve() {
        auto B = A.dup;
        Tuple!(int, int)[] C;
        B.sort!"a[0] == b[0] ? a[1] > b[1] : a[0] < b[0]";
        
        int left = 1;
        foreach (b; B) {
            if (b[0] == 0) {
                C ~= b;
            } else if (b[0] >= left) {
                left += 1;
            } else {
                C ~= b;
            }
        }

        int right = M;
        C.sort!"a[1] > b[1]";
        foreach (c; C) {
            if (right < left) {
                break;
            }
            if (c[1] <= right) {
                right -= 1;
            }
        }

        return (left - 1) + (M - right);
    }

    int ans = solve;
    foreach (i; 0..N) {
        A[i] = tuple(M - A[i][1] + 1, M - A[i][0] + 1);
    }
    ans = max(ans, solve);

    writeln(N - ans);
}
