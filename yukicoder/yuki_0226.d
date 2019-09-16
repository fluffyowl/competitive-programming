import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.chomp).array;
    long ans = 0;

    // 交互パターン
    {
        long tmp = 1;
        foreach (i; 0..H) {
            int zero = -1;
            foreach (j; 0..W) {
                if (A[i][j] == '0' && zero == -1) {
                    zero = j % 2;
                } else if (A[i][j] == '0' && zero != j % 2) {
                    tmp = 0;
                    break;
                } else if (A[i][j] == '1' && zero == -1) {
                    zero = 1 - j % 2;
                } else if (A[i][j] == '1' && zero != 1 - j % 2) {
                    tmp = 0;
                    break;
                }
            }
            if (zero == -1) {
                tmp = tmp * 2 % MOD;
            }
        }
        ans = (ans + tmp) % MOD;
    }

    // どこかに2連続があるパターン
    foreach (jj; 0..W-1) {
        foreach (k; 0..2) {
            long tmp = 1;
            auto row = new int[][](2, W);
            foreach (i; 0..2) fill(row[i], -1);
            foreach (jjj; 0..jj) row[0][jjj] = k ^ ((jj-jjj)%2);
            foreach (jjj; 0..jj) row[1][jjj] = row[0][jjj] ^ 1;
            row[0][jj] = row[0][jj+1] = k;
            row[1][jj] = row[1][jj+1] = k ^ 1;
            bool turn = false;
            outer: foreach (i; 0..H) {
                foreach (j; 0..W) {
                    if (A[i][j] == '?') continue;
                    bool b = A[i][j] == '1';
                    if (row[turn][j] != -1 && row[turn][j] != b) {
                        tmp = 0;
                        break outer;
                    }
                    if (row[turn^1][j] != -1 && row[turn^1][j] == b) {
                        tmp = 0;
                        break outer;
                    }
                    row[turn][j] = b;
                    row[turn^1][j] = b^1;
                }
                turn ^= 1;
            }
            if (tmp == 0) {
                continue;
            }
            long cnt = row[0].map!(x => x == -1).sum;
            ans = (ans + powmod(2, cnt, MOD)) % MOD;
        }
    }

    ans.writeln;
}


long powmod(long a, long x, long m) {
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

