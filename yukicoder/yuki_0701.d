import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto ans = new dchar[](20);
    ans.fill('a');

    void incl() {
        for (int i = 18; i >= 1; --i) {
            ans[i] += 1;
            if (ans[i] > 'z') {
                ans[i] = 'a';
            } else {
                break;
            }
        }
    }

    while (N--) {
        if (N == 0)
            ans[$-1] = 'n';
        ans.writeln;
        incl;
    }
}

