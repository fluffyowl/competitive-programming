import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    auto ans = new int[](N*N);
    foreach (i; 0..N) ans[A[i] - 1] = i + 1;
    
    auto front = N.iota.array;
    auto back = N.iota.map!(i => N - i - 1).array;

    auto pq1 = new BinaryHeap!(Array!(Tuple!(int, int)), "a[0] > b[0]");
    auto pq2 = new BinaryHeap!(Array!(Tuple!(int, int)), "a[0] > b[0]");
    foreach (i; 1..N) pq1.insert(tuple(A[i] - 1, i + 1));
    pq2.insert(tuple(A[0] - 1, 1));

    foreach (i; 0..N*N) {
        if (ans[i] > 0) {
            continue;
        } else if (!pq1.empty) {
            auto t = pq1.front;
            auto pos = t[0];
            auto num = t[1];
            if (pos < i) {
                writeln("No");
                return;
            }
            ans[i] = num;
            front[num-1] -= 1;
            if (front[num-1] == 0) {
                pq1.removeFront;
                if (num != N) pq2.insert(tuple(pos, num));
            }
        } else if (!pq2.empty) {
            auto t = pq2.front;
            auto pos = t[0];
            auto num = t[1];
            if (pos > i) {
                writeln("No");
                return;
            }
            ans[i] = num;
            back[num-1] -= 1;
            if (back[num-1] == 0) pq2.removeFront;
        } else {
            writeln("No");
            return;
        }
    }

    writeln("Yes");
    ans.map!(a => a.to!string).join(" ").writeln;
}
