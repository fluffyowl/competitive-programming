import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


immutable int MAX = 1000000;
alias Tuple!(int, "r", int, "i") Work;
alias Tuple!(int, "n", int, "i") Node;

void main() {
    auto N = readln.chomp.to!int;
    auto L = new int[](N);
    auto R = new int[](N);
    auto W = new Work[][](MAX+10);
    
    foreach (i; 0..N) {
        auto s = readln.split.map!(to!int).array;
        L[i] = s[0];
        R[i] = s[1];
        W[s[0]] ~= Work(s[1], i);
    }

    auto dp = new Node[](MAX+10);
    fill(dp, Node(0, -1));

    for (int i = MAX-1; i >= 0; i--) {
        dp[i] = dp[i+1];
        foreach (w; W[i]) {
            if ((dp[w.r].n + 1 > dp[i].n) ||
                (dp[w.r].n + 1 == dp[i].n && w.i < dp[i].i))
                dp[i] = Node(dp[w.r].n + 1, w.i);
        }
    }


    int[] ans;
    int pos = 0;
    while (pos <= MAX && dp[pos].i != -1) {
        ans ~= dp[pos].i + 1;
        pos = R[dp[pos].i];
    }
    
    writeln(dp[0].n);
    ans.map!(n => n.to!string).join(" ").writeln;
}
