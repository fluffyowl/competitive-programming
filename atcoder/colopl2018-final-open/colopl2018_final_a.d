import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.regex;

void main() {
    auto K = readln.chomp.to!long;
    auto S = readln.chomp;
    auto N = S.length.to!int;
    auto T = S.split(ctRegex!(`B+`)).map!(s => s.length.to!long).array;
    long ans = 0;

    if (S.map!(s => s == 'A').all) {
        writeln(N*K*(N*K+1)/2);
        return;
    }

    foreach (i; 0..T.length) {
        if (i == 0 && S.front == 'A' && S.back == 'A') {
            ans += T[0] * (T[0] + 1) / 2;
        } else if (i + 1 == T.length && S.front == 'A' && S.back == 'A') {
            ans += T[$-1] * (T[$-1] + 1) / 2;
        } else {
            ans += T[i] * (T[i] + 1) / 2 * K;
        }
    }

    if (S.front == 'A' && S.back == 'A') {
        ans += (T.front + T.back) * (T.front + T.back + 1) / 2 * (K - 1);
    }


    ans.writeln;
}
