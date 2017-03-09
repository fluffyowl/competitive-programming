import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


alias Tuple!(long, "up", long, "down") Magic;

void main() {
    auto N = readln.chomp.to!int;
    Magic[] posi, nega;
    foreach (i; 0..N) {
        auto s = readln.split.map!(to!long);
        if (s[0] - s[1] > 0)
            posi ~= Magic(s[0], s[1]);
        else
            nega ~= Magic(s[0], s[1]);
    }

    posi.sort!"a.down > b.down"();
    nega.sort!"a.up < b.up"();
    long ans = 0;
    long tmp = 0;
    foreach (a; nega ~ posi) {
        tmp += a.up;
        ans = max(ans, tmp);
        tmp -= a.down;
    }

    ans.writeln;
}
