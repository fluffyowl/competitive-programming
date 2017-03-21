import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

long solve_one(long N) {
    string n = N.to!string;
    int m = n.length.to!int;
    auto dp = new long[][][][](m+1, 2, 2, 8); // 桁, n未満か, 前の数字が1か, これまで何個の12があったか
    dp[0][0][0][0] = 1;

    foreach (i; 0..m) {
        foreach (j; 0..2) {
            foreach (k; 0..2) {
                foreach (l; 0..7) {
                    int digit = j ? 10 : (n[i]-'0'+1);
                    foreach (d; 0..digit) {
                        dp[i+1][j|(d<n[i]-'0')][d==1][l+(k==1&&d==2)] += dp[i][j][k][l];
                    }
                }
            }
        }
    }

    long ret = 0;
    foreach (k; 0..2) {
        foreach (l; 1..8) {
            ret += (dp[m][1][k][l]) * l;
        }
    }
    return ret;
}

long solve_two(long N) {
    string n = N.to!string;
    int m = n.length.to!int;
    auto dp = new long[][][][](m+1, 2, 10, 2); // 桁, n未満か, 最初の桁の数字, 最後の桁が1か
    dp[0][0][0][0] = 1;

    foreach (i; 0..m) {
        foreach (j; 0..2) {
            foreach (k; 0..10) {
                foreach (l; 0..2) {
                    int digit = j ? 10 : (n[i]-'0'+1);
                    foreach (d; 0..digit) {
                        int first = (k == 0 && d != 0) ? d : k;
                        dp[i+1][j|(d<n[i]-'0')][first][i==m-1&&d==1] += dp[i][j][k][l];
                    }
                }
            }
        }
    }

    return dp[m][1][2][1];
    
}


void main() {
    auto s = readln.split;
    auto a = s[0].to!long;
    auto b = s[1].to!long;
    long ans1 = solve_one(b+1) - solve_one(a);
    long ans2 = max(0, solve_two(b) - solve_two(a));
    long ans = ans1 + ans2;
    if (a == 1 && b > 1) ans += 1;
    //if (s[1][0] == '2' && s[1][$-1] == '1') ans -= 1;
    ans.writeln;
    //ans1.writeln;
    //ans2.writeln;
}

