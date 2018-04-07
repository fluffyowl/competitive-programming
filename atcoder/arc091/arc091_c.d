import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto A = s[1];
    auto B = s[2];

    if (N > 1L * A * B || N < A + B - 1) {
        writeln(-1);
        return;
    }

    auto lens = new int[](A);
    lens.fill(1);
    lens[0] = B;

    int rest = N - B - A + 1;
    for (int i = 1; i < N && rest > 0; ++i) {
        int x = min(B-1, rest);
        lens[i] += x;
        rest -= x;
    }

    auto ans = new int[](N);
    int pos = 0;
    int num = 1;
    foreach (i; 0..A) {
        foreach (j; 0..lens[i]) {
            ans[pos+lens[i]-j-1] = num++;
        }
        pos += lens[i];
    }

    
    ans.map!(to!string).join(" ").writeln;
}
