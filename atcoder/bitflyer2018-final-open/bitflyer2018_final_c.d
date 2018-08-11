import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;


void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;
    auto A = new long[](N+1);
    foreach (i; 0..N) A[i+1] = S[i] == '(' ? A[i] + 1 : A[i] - 1;
    auto pq = new BinaryHeap!(Array!long, "a < b")();
    long[long] cnt;

    long ans = 0;
    foreach (i; 0..N) {
        if (S[i] == '(') {
            pq.insert(A[i]);
            cnt[A[i]] += 1;
        }
        else {
            while (!pq.empty && pq.front > A[i+1]) {
                cnt[pq.front] -= 1;
                pq.removeFront;
            }
            if (A[i+1] in cnt) {
                ans += cnt[A[i+1]];
            }
        }
    }

    ans.writeln;
}
