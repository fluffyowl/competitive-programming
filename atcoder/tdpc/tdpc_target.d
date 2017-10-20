import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable int INF = 1 << 29;

void main() {
    auto N = readln.chomp.to!int;
    auto C = N.iota.map!(_ => readln.split.map!(to!int).array).array;
    C.sort!"a[0] - a[1] < b[0] - b[1]"();

    auto LIS = new int[](N + 1);
    LIS.fill(-INF);
    LIS[0] = INF;

    for (int i = 0; i < N; ) {
        Tuple!(int, int)[] tmp;
        do {
            auto lb = LIS.assumeSorted!"a > b".lowerBound(C[i][0] + C[i][1]).length.to!int;
            tmp ~= tuple(lb, C[i][0] + C[i][1]);
            ++i;
        } while (i < N && C[i][1] - C[i][0] == C[i-1][1] - C[i-1][0]);

        foreach (t; tmp)
            LIS[t[0]] = max(LIS[t[0]], t[1]);
    }

    (N + 1).iota.filter!(i => LIS[i] != -INF).reduce!max.writeln;
}
