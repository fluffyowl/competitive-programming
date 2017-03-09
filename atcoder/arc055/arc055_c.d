import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


int[] z_algorithm(string s) {
    int n = s.length.to!int;
    auto ans = new int[](n);
    int L, R;
    
    foreach (i; 1..n) {
        if (i > R || ans[i-L] >= R-i+1) {
            L = i;
            R = (i > R) ? i - 1 : R;
            while (R+1 < n && s[R-L+1] == s[R+1]) R++;
            ans[i] = R - L + 1;
        }
        else {
            ans[i] = ans[i-L];
        }
    }

    return ans;
}

void main() {
    auto s = readln.chomp;
    auto u = s.dup;
    u.reverse();
    auto t = u.to!string;
    auto x = z_algorithm(s);
    auto y = z_algorithm(t);
    y.reverse();
    auto n = s.length.to!int;

    //x.writeln;
    //y.writeln;

    long ans = 0;
    foreach (i; n/2+1..n-1) {
        if (x[i] > 0 && y[i-1] > 0 && x[i] + y[i-1] >= n - i) {
            int a = min(x[i], n - i - 1);
            int c = min(y[i-1], n - i - 1);
            int tmp = min(a + c - n + i + 1, n-i-1);
            ans += max(0, tmp);
        }
    }
    ans.writeln;
}

unittest {
    assert(z_algorithm("aaaaaa") == [0, 5, 4, 3, 2, 1]);
    assert(z_algorithm("aabaacd") == [0, 1, 0, 2, 1, 0, 0]);
    assert(z_algorithm("abababab") == [0, 0, 6, 0, 4, 0, 2, 0]);
    assert(z_algorithm("aabcaabxaaaz") == [0, 1, 0, 0, 3, 1, 0, 0, 2, 2, 1, 0]);
}
