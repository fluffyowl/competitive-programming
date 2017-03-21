import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable int M = 1000;
immutable int N = 8;

int D, T;
int[] C, A;

void _read() {
    auto s = readln.split.map!(to!int);
    D = s[0];
    T = s[1];
    C = readln.split.map!(to!int).array;
    A = readln.split.map!(to!int).array;
}

void _pass() {
    writeln("pass");
    stdout.flush;
}

void _fill(int i) {
    writeln("fill ", i+1);
    stdout.flush;
}

void _sell(int[] s) {
    writeln("sell ", s.length, " ", s.map!(to!string).join(" "));
    stdout.flush;
}

void main() {
    bool sold = true;

    auto dp = new int[][][](N, 51);

    foreach (_; 0..M) {
        _read;

        if (sold) {
            dp = new int[][][](N, 51);
            dp[0][C[0]] = [1];
            foreach (i; 1..N) {
                foreach (j; 0..51) {
                    if (dp[i-1][j].length > 0) {
                        if (dp[i][j].length == 0 ||
                            dp[i][j].length < dp[i-1][j].length)
                            dp[i][j] = dp[i-1][j].dup;
                    }
                    if (dp[i-1][j].length > 0 && C[i] + j <= 50) {
                        dp[i][C[i]+j] = dp[i-1][j] ~ (i+1);
                    }
                }
                if (dp[i][C[i]].length == 0)
                    dp[i][C[i]] = [i+1];
            }
        }

        sold = false;
        bool cont = false;
        foreach (i; 0..N) {
            if (A[i] == 0) {
                _fill(i);
                cont = true;
                break;
            }
        }
        if(cont) continue;

        if (dp[N-1][D].length > 0) {
            _sell(dp[N-1][D]);
            sold = true;
        }
        else {
            _pass;
        }
    }
}
