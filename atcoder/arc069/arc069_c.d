import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


alias Tuple!(int, "i", long, "n") Mt;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    auto B = new Mt[](N);
    foreach (i, a; enumerate(A)) {
        B[i] = Mt(i.to!int, a);
    }
    B.sort!"a.n == b.n ? a.i > b.i : a.n > b.n"();
    auto ans = new long[](N);
    fill(ans, 0);

    auto s = int.max;
    foreach (i; 0..N-1) {
        s = min(s, B[i].i);
        if (s == 0) break;
        if (B[i].n == B[i+1].n)
            continue;
        ans[s] += (B[i].n - B[i+1].n) * (i+1);
    }

    ans[0] = A.sum - ans.sum;
    ans.each!(writeln);
}
