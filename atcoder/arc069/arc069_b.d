import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;

int N;
string S;
char[] ans;

bool solve() {
    foreach (i; 1..N-1) {
        auto prev = ans[(i-1+N)%N];
        if (ans[i] == 'S' && S[i] == 'o') {
            ans[(i+1)%N] = prev;
        }
        else if (ans[i] == 'S' && S[i] == 'x') {
            ans[(i+1)%N] = (prev == 'S') ? 'W' : 'S';
        }
        else if (ans[i] == 'W' && S[i] == 'o') {
            ans[(i+1)%N] = (prev == 'S') ? 'W' : 'S';
        }
        else {
            ans[(i+1)%N] = prev;
        }
    }

    foreach (i; 0..N) {
        auto prev = ans[(i-1+N)%N];
        auto next = ans[(i+1)%N];
        if (ans[i] == 'S' && S[i] == 'o' && prev != next) return false;
        else if (ans[i] == 'S' && S[i] == 'x' && prev == next) return false;
        else if (ans[i] == 'W' && S[i] == 'o' && prev == next) return false;
        else if (ans[i] == 'W' && S[i] == 'x' && prev != next) return false;
    }

    return true;
}

void main() {
    N = readln.chomp.to!int;
    S = readln.chomp;

    ans = new char[](N);
    auto cand = ["SS", "SW", "WS", "WW"];
    foreach (i; 0..4) {
        foreach (j; 0..N) ans[j] = '*';
        ans[0] = cand[i][0];
        ans[1] = cand[i][1];
        if (solve) {
            ans.writeln;
            return;
        }
    }

    writeln(-1);
}
